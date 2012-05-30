package CommunityBuilder::Schema::Result::Cluster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CommunityBuilder::Schema::Result::Cluster

=cut

__PACKAGE__->table("cluster");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 100

=head2 country

  data_type: 'varchar'
  default_value: 'United States'
  is_nullable: 0
  size: 100

=head2 region

  data_type: 'varchar'
  default_value: 'Southeastern States'
  is_nullable: 0
  size: 100

=head2 name

  data_type: 'varchar'
  default_value: 'Fairfax'
  is_nullable: 0
  size: 100

=head2 geo_size

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 population

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 num_lsa

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 num_comm

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 100 },
  "country",
  {
    data_type => "varchar",
    default_value => "United States",
    is_nullable => 0,
    size => 100,
  },
  "region",
  {
    data_type => "varchar",
    default_value => "Southeastern States",
    is_nullable => 0,
    size => 100,
  },
  "name",
  {
    data_type => "varchar",
    default_value => "Fairfax",
    is_nullable => 0,
    size => 100,
  },
  "geo_size",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "population",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "num_lsa",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "num_comm",
  { data_type => "int", default_value => 0, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("user_id_unique", ["user_id"]);

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<CommunityBuilder::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "CommunityBuilder::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 core_team_members

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::CoreTeamMember>

=cut

__PACKAGE__->has_many(
  "core_team_members",
  "CommunityBuilder::Schema::Result::CoreTeamMember",
  { "foreign.cluster_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);

=head2 neighborhoods

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::Neighborhood>

=cut

__PACKAGE__->has_many(
  "neighborhoods",
  "CommunityBuilder::Schema::Result::Neighborhood",
  { "foreign.cluster_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-05-26 18:11:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TOMH3kfUja6WuPo+XrP07w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
