use utf8;
package CommunityBuilder::Schema::Result::TeachingTeamMember;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::TeachingTeamMember

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<teaching_team_member>

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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

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
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-27 17:56:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WLRZrf3nhaYOunpZeSaM2g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
