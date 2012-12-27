use utf8;
package CommunityBuilder::Schema::Result::Visit;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CommunityBuilder::Schema::Result::Visit

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

=head1 TABLE: C<visit>

=cut

__PACKAGE__->table("visit");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 home_id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 1

=head2 date_of

  data_type: 'date'
  is_nullable: 0

=head2 cycle

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 visitors

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

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
  "date_of",
  { data_type => "date", is_nullable => 0 },
  "cycle",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "visitors",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
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
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-27 17:56:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Zm+Pmzmdh4/L9n9xoP0BpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
