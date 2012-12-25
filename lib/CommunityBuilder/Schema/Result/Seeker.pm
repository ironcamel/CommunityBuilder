use utf8;
package CommunityBuilder::Schema::Result::Seeker;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::Seeker

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

=head1 TABLE: C<seeker>

=cut

__PACKAGE__->table("seeker");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 home_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

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

=head2 anna

  data_type: 'int'
  default_value: 0
  is_nullable: 0

=head2 declared

  data_type: 'date'
  is_nullable: 1

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
  "home_id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "anna",
  { data_type => "int", default_value => 0, is_nullable => 0 },
  "declared",
  { data_type => "date", is_nullable => 1 },
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

=head2 home

Type: belongs_to

Related object: L<CommunityBuilder::Schema::Result::Home>

=cut

__PACKAGE__->belongs_to(
  "home",
  "CommunityBuilder::Schema::Result::Home",
  { id => "home_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-25 19:53:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GjKmcbgnz/NFMSQqmoqBqA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
