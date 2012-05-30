package CommunityBuilder::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CommunityBuilder::Schema::Result::User

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cluster

Type: might_have

Related object: L<CommunityBuilder::Schema::Result::Cluster>

=cut

__PACKAGE__->might_have(
  "cluster",
  "CommunityBuilder::Schema::Result::Cluster",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-05-21 03:02:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g7hYAkMYhuS1yYLtOGnebg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
