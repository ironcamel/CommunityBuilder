package CommunityBuilding;
use Dancer ':syntax';
use re '/aa';

use Dancer::Plugin::DBIC;
use Dancer::Plugin::Passphrase;
use Geography::Countries qw(countries);
use Locale::US;
use Try::Tiny;

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
        my $username = param 'new_username';
        my $password = param 'new_password';
        my $email    = param 'email';
        info "Request to create a new user with params: ", scalar params;
        unless ($username and $password and $email) {
            info "Not all required fields were provided.";
            return template login => {
                err_msg => "Username, password, and email are required to"
                    . " create a new user",
            };
        }
        return template login => { err_msg => "Invalid username" }
            if $username !~ /^\w+$/ or $username eq 'admin';
        $password = passphrase($password)->generate_hash;
        my $user = {
            id       => $username,
            password => "$password",
            email    => $email,
        };
        debug "Going to create: ", $user;
        try {
            schema->txn_do(sub {
                schema->resultset('User')->create($user);
                schema->resultset('Cluster')->create({ user_id => $username });
            });
        } catch {
            error "Error creating user in db: $_";
            my $err_msg = /column id is not unique/
                ? "The username '$username' is already taken."
                : "Could not create user '$username'";
            return template login => { err_msg => $err_msg };
        }
        session user_id => $username;
        return redirect uri_for '/';
    } else { # Handle login
        my $username = param 'username';
        my $password = param 'password';
        my $passphrase = passphrase($password);
        my $user = schema->resultset('User')->find($username);
        if ($user and $passphrase->matches($user->password)) {
            session user_id => $username;
            return redirect uri_for(params->{path} || '/');
        } else {
            session user_id => undef;
            return template login => {
                err_msg => "Invalid username or password"
            };
        }
    }
};

get '/logout' => sub {
    session user_id => undef;
    return redirect uri_for '/login';
};

get '/' => sub {
    my $cluster = cluster();
    template cluster => {
        #countries => [ countries() ],
        states            => $STATES,
        cluster           => $cluster,
        neighborhoods     => [ $cluster->neighborhoods ],
        core_team_members => [ $cluster->core_team_members ],
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

post '/ajax/update_cluster' => sub {
    my $params = params;
    info "Updating cluster: ", $params;
    try {
        cluster()->update($params);
    } catch {
        error "Could not update cluster: $_";
        return status 500;
    };
    return '';
};

post '/ajax/add_core_member' => sub {
    my $params = params;
    info "Adding core team member: ", $params;
    my $member = try {
        cluster()->add_to_core_team_members($params);
    } catch {
        error "Could not add core team member: $_";
        return status 500;
    };
    $params->{id} = $member->id;
    return $params;
};

post '/ajax/delete_core_member' => sub {
    my $params = params;
    info "Deleting core team member: ", $params;
    try {
        my $m = cluster()->core_team_members({ id => param 'id' });
        $m->delete();
    } catch {
        error "Could not delete core team member: $_";
        return status 500;
    };
    return '';
};

post '/ajax/add_neighborhood' => sub {
    my $params = params;
    info "Adding neighborhood: ", $params;
    my $nhood = try {
        cluster()->add_to_neighborhoods($params);
    } catch {
        error "Could not add neighborhood: $_";
        return status 500;
    };
    $params->{id} = $nhood->id;
    return $params;
};

post '/ajax/delete_nhood' => sub {
    my $params = params;
    info "Deleting neighborhood: ", $params;
    try {
        my $m = cluster()->neighborhoods({ id => param 'id' });
        $m->delete();
    } catch {
        error "Could not delete neighborhood: $_";
        return status 500;
    };
    return '';
};

sub cluster {
    return schema->resultset('Cluster')->find({ user_id => session 'user_id' });
}

true;
