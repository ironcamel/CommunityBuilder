package CommunityBuilder::Schema::Result::TeachingTeamMember;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CommunityBuilder::Schema::Result::TeachingTeamMember

=cut

__PACKAGE__->table("teaching_team_member");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 neighborhood_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 role

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 availability

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 active

  data_type: 'int'
  default_value: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "neighborhood_id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "role",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "availability",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "active",
  { data_type => "int", default_value => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 neighborhood

Type: belongs_to

Related object: L<CommunityBuilder::Schema::Result::Neighborhood>

=cut

__PACKAGE__->belongs_to(
  "neighborhood",
  "CommunityBuilder::Schema::Result::Neighborhood",
  { id => "neighborhood_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-06-04 04:37:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ieU+Mb1nlz0RYB8uyH1BDA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
