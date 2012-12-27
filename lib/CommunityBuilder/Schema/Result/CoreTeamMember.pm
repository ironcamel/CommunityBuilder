use utf8;
package CommunityBuilder::Schema::Result::CoreTeamMember;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::CoreTeamMember

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

=head1 TABLE: C<core_team_member>

=cut

__PACKAGE__->table("core_team_member");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 cluster_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 last_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 phone

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 email

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 role

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 100

=head2 active

  data_type: 'int'
  default_value: 1
  is_nullable: 0

=head2 date_appointed

  data_type: 'date'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "cluster_id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "last_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "phone",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "email",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "role",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 100 },
  "active",
  { data_type => "int", default_value => 1, is_nullable => 0 },
  "date_appointed",
  { data_type => "date", is_nullable => 1 },
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
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-27 17:56:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3j+6B2YnPQhYwBbHSNmSAA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
