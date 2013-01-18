package CommunityBuilding;
use Dancer ':syntax';
use re '/aa';

use Dancer::Plugin::DBIC qw(schema);
use Dancer::Plugin::EscapeHTML;
use Dancer::Plugin::Passphrase;
use Dancer::Plugin::Res;
use Email::Valid;
use DateTime;
use Geography::Countries qw(countries);
use Locale::US;
use TryCatch;

our $VERSION = '0.0001';

my $STATES = [ Locale::US->new()->all_state_codes ];

hook before => sub {
    return if session('user_id')
        or request->path_info =~ m{^/(login|create-user)};
    var requested_path => request->path_info;
    request->path_info('/login');
};
 
get '/login' => sub {
    template login => { path => vars->{requested_path} };
};
 
post '/login' => sub {

    if (param 'create-user') {
        my $password = param 'new_password';
        my $email    = param 'new_email';
        info "Request to create a new user with params: ", scalar params;
        unless ($password and $email) {
            info "Not all required fields were provided.";
            return template login => {
                err_msg => "An email and password are required to"
                    . " create a new user",
            };
        }
        if (not Email::Valid->address($email)) {
            return template login => {
                err_msg => 'Email is invalid',
            };
        }
        $password = passphrase($password)->generate_hash;
        my $user_data = {
            password => "$password",
            email    => $email,
        };
        debug "Going to create: ", $user_data;
        try {
            my $user;
            schema->txn_do(sub {
                $user = schema->resultset('User')->create($user_data);
                $user->discard_changes;
                schema->resultset('Cluster')->create({ user_id => $user->id });
            });
            set_session_user($user);
        } catch ($err) {
            error "Error creating user in db: ", $err;
            my $err_msg = $err =~ /column .* is not unique/
                ? "An account for $email already exists."
                : 'Could not create account. Contact ' . setting 'admin_email';
            return template login => { err_msg => $err_msg };
        }
        return redirect uri_for '/';
    } else { # Handle login
        my $email = param 'email';
        my $password = param 'password';
        my $passphrase = passphrase($password);
        my $user = schema->resultset('User')->find({ email => $email});
        if ($user and $passphrase->matches($user->password)) {
            set_session_user($user);
            return redirect uri_for(params->{path} || '/');
        } else {
            clear_session_user();
            return template login => {
                err_msg => "Invalid email or password"
            };
        }
    }
};

get '/logout' => sub {
    clear_session_user();
    return redirect uri_for '/login';
};

get '/' => sub {
    my $cluster = cluster();
    template cluster => {
        #countries => [ countries() ],
        states            => $STATES,
        cluster           => dbic_to_hash($cluster),
        neighborhoods     => [ dbic_to_hash($cluster->neighborhoods) ],
        core_team_members => [ dbic_to_hash($cluster->core_team_members) ],
        #core_team_members => [ $cluster->core_team_members ],
        clusters => [
            'Fairfax',
            'Falls Church',
            'Springfield',
        ],
        regions => [
            'Central States',
            'Northeastern States',
            'Northwestern States',
            'South Central States',
            'Southeastern States',
            'Southwestern States',
        ],
    };
};

get '/neighborhoods/:id' => sub {
    my $nhood = cluster()->neighborhoods->find(param 'id')
        or return res 404, template '404';
    template neighborhood => {
        nhood        => $nhood,
        team_members => [ dbic_to_hash($nhood->teaching_team_members) ],
        homes        => [ dbic_to_hash($nhood->homes) ],
    };
};

post '/neighborhoods' => sub {
    my $params = params('body');
    info "Adding neighborhood: ", $params;
    try {
        cluster()->add_to_neighborhoods($params);
    } catch ($err) {
        error "Could not add neighborhood: ", $err;
        return res 500, template 500;
    }
    redirect uri_for '/';
};

post '/neighborhoods/:nid/homes' => sub {
    my $nid = param 'nid';
    my $nhood = cluster()->neighborhoods->find($nid)
        or return res 404, template 404;
    my $address = param 'address'
        or return res 400, 'The address is missing';
    my $now = DateTime->now;
    $nhood->homes->create({
        params('body'),
        created  => $now->ymd,
        modified => $now->ymd,
    });
    redirect uri_for "/neighborhoods/$nid";
};

get '/neighborhoods/:nid/homes/:hid' => sub {
    my $nid = param 'nid';
    my $nhood = cluster()->neighborhoods->find($nid)
        or return res 404, template '404';
    my $home_id = param 'hid';
    my $home = $nhood->homes->find($home_id)
        or return res 404, 'No such home';
    template home => {
        nhood   => $nhood,
        home    => $home,
        seekers => [ dbic_to_hash($home->seekers->all) ],
        visits  => [ dbic_to_hash($home->visits->all) ],
    };
};

post '/neighborhoods/:nid/homes/:hid/seekers' => sub {
    my $nid = param 'nid';
    my $home_id = param 'hid';
    my $nhood = cluster()->neighborhoods->find($nid)
        or return res 404, template '404';
    my $home = $nhood->homes->find($home_id)
        or return res 404, template '404';
    my $name = param 'name'
        or return res 400, 'The name is missing';
    my $now = DateTime->now;
    $home->seekers->create({
        params('body'),
        created  => $now->ymd,
        modified => $now->ymd,
    });
    redirect uri_for "/neighborhoods/$nid/homes/$home_id";
};

post '/neighborhoods/:nid/homes/:hid/visits' => sub {
    my $nid = param 'nid';
    my $home_id = param 'hid';
    my $nhood = cluster()->neighborhoods->find($nid)
        or return res 404, template '404';
    my $home = $nhood->homes->find($home_id)
        or return res 404, template '404';
    my $date_of = param 'date_of'
        or return res 400, 'The date is missing';
    my $now = DateTime->now;
    $home->visits->create({
        params('body'),
        created  => $now->ymd,
        modified => $now->ymd,
    });
    redirect uri_for "/neighborhoods/$nid/homes/$home_id";
};

post '/ajax/update_cluster' => sub {
    my $params = params;
    info "Updating cluster: ", $params;
    try {
        cluster()->update($params);
    } catch ($err) {
        error "Could not update cluster: $err";
        return status 500;
    };
    return '';
};

get '/ajax/get_core_member' => sub {
    my $id = param 'id';
    debug "Getting core team member with id: $id";
    my $m = cluster()->core_team_members->find({ id => $id }) or return res 404;
    return { $m->get_columns };
};

post '/ajax/add_core_member' => sub {
    my $params = params;
    info "Adding core team member: ", $params;
    my $member = eval { cluster()->add_to_core_team_members($params) };
    if ($@) {
        error "Could not add core team member: $@";
        return res 500, "Could not add core team member";
    };
    $params->{id} = $member->id;
    return $params;
};

post '/ajax/edit_core_member' => sub {
    my $params = params;
    my $id = param 'id';
    info "Updating core team member: ", $params;
    my $m = cluster()->core_team_members->find({ id => $id }) or return res 404;
    $m->update($params) if $m;
    return $params;
};

post '/ajax/delete_core_member' => sub {
    my $params = params;
    info "Deleting core team member: ", $params;
    my $m = cluster()->core_team_members({ id => param 'id' })
        or return res 404;
    $m->delete();
    return '';
};

post '/ajax/delete_nhood' => sub {
    my $params = params;
    info "Deleting neighborhood: ", $params;
    try {
        my $m = cluster()->neighborhoods({ id => param 'id' });
        $m->delete_all();
    } catch ($err) {
        error "Could not delete neighborhood: $err";
        return res 500;
    }
    return {};
};

post '/ajax/add_teaching_team_member' => sub {
    my $params = params;
    info "Adding teaching team member: ", $params;
    my $nhood_id = delete $params->{nhood_id};
    my $nhood = cluster()->neighborhoods->find($nhood_id)
        or return res 400, "No such neighborhood";
    try {
        my $member = $nhood->add_to_teaching_team_members($params);
        $params->{id} = $member->discard_changes->id;
        return $params;
    } catch ($err) {
        error "Could not add core team member: $err";
        return res 500;
    }
};

post '/ajax/delete_teaching_team_member' => sub {
    my $params = params;
    info "Deleting core team member: ", $params;
    my $nhood_id = param 'nhood_id';
    my $nhood = cluster()->neighborhoods->find($nhood_id)
        or return res 400, "No such neighborhood";
    my $m = $nhood->teaching_team_members->find(param 'id')
        or return res 400, "No such member";
    $m->delete();
    return {};
};

post '/ajax/delete_visit' => sub {
    my $params = params('body');
    info "Deleting visit: ", $params;
    try {
        schema->resultset('Visit')->search($params)->delete_all;
    } catch ($err) {
        error "Could not delete visit: $err";
        return res 500;
    }
    return {};
};

sub cluster {
    return schema->resultset('Cluster')->find({ user_id => session 'user_id' });
}

sub dbic_to_hash { map +{ $_->get_columns }, @_ }

sub set_session_user {
    my ($user) = @_;
    session user_id => $user->id;
    session email => $user->email;
}

sub clear_session_user {
    session user_id => undef;
    session email => undef;
}

true;
