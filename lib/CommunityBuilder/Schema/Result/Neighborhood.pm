package CommunityBuilder::Schema::Result::Neighborhood;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

CommunityBuilder::Schema::Result::Neighborhood

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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-05-26 18:11:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r3YK3r6U+gtw7LQyOy1MWw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
