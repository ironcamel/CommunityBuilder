use utf8;
package CommunityBuilder::Schema::Result::Neighborhood;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::Neighborhood

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

=head1 TABLE: C<neighborhood>

=cut

__PACKAGE__->table("neighborhood");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 cluster_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 coordinator

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 address

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 200

=head2 city

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 state

  data_type: 'varchar'
  default_value: 'VA'
  is_nullable: 0
  size: 2

=head2 zip_code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 office_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 office_title

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 office_phone

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 office_email

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 notes

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "cluster_id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "coordinator",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "address",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 200 },
  "city",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "state",
  { data_type => "varchar", default_value => "VA", is_nullable => 0, size => 2 },
  "zip_code",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "office_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "office_title",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "office_phone",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "office_email",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "notes",
  { data_type => "text", default_value => "", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cluster

Type: belongs_to

Related object: L<CommunityBuilder::Schema::Result::Cluster>

=cut

__PACKAGE__->belongs_to(
  "cluster",
  "CommunityBuilder::Schema::Result::Cluster",
  { id => "cluster_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 homes

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::Home>

=cut

__PACKAGE__->has_many(
  "homes",
  "CommunityBuilder::Schema::Result::Home",
  { "foreign.neighborhood_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);

=head2 teaching_team_members

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::TeachingTeamMember>

=cut

__PACKAGE__->has_many(
  "teaching_team_members",
  "CommunityBuilder::Schema::Result::TeachingTeamMember",
  { "foreign.neighborhood_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-23 08:02:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jDpVgvyKP8fdALh+acOYFQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
