use utf8;
package CommunityBuilder::Schema::Result::Home;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::Home

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

=head1 TABLE: C<home>

=cut

__PACKAGE__->table("home");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 neighborhood_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 address

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 city

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 zip_code

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 anna

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 devotional

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 created

  data_type: 'date'
  is_nullable: 1

=head2 modified

  data_type: 'date'
  is_nullable: 1

=head2 notes

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "neighborhood_id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "address",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "city",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "state",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "zip_code",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "anna",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "devotional",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "created",
  { data_type => "date", is_nullable => 1 },
  "modified",
  { data_type => "date", is_nullable => 1 },
  "notes",
  { data_type => "text", is_nullable => 1 },
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
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 seekers

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::Seeker>

=cut

__PACKAGE__->has_many(
  "seekers",
  "CommunityBuilder::Schema::Result::Seeker",
  { "foreign.home_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);

=head2 visits

Type: has_many

Related object: L<CommunityBuilder::Schema::Result::Visit>

=cut

__PACKAGE__->has_many(
  "visits",
  "CommunityBuilder::Schema::Result::Visit",
  { "foreign.home_id" => "self.id" },
  { cascade_copy => 1, cascade_delete => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-26 11:28:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SGkI9EU1j3zvRg5LVq8QXQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
