=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=head1 NAME

Bio::EnsEMBL::IO::Object::ColumnBasedGeneric - Generic object for holding column/field based records

=head1 SYNOPSIS

  use Bio::EnsEMBL::IO::Object::ColumnBasedGeneric;

  $fields = qw/seqname source type start/;
  my $obj = Bio::EnsEMBL::IO::Object::ColumnBasedGeneric->new($fields);

  OR

  use Bio::EnsEMBL::IO::Object::ColumnBasedGeneric;
  use Bio::EnsEMBL::IO::Parser::GFF3;

  my $parser = Bio::EnsEMBL::IO::Parser::GFF3->open('myfile.gff3');
  my $obj = Bio::EnsEMBL::IO::Object::ColumnBasedGeneric->new($parser->get_fields);

  $obj->munrge_seqname('my_seq');

=head1 Description

An object to hold a generic column based format's record as a structure. Allows access to
elements via setters/getters. Setter/getters are dynamically added to the class on instantiation.

=cut

package Bio::EnsEMBL::IO::Object::ColumnBasedGeneric;

use strict;
use warnings;
use Carp;

sub new {
    my ($class, $fields) = @_;

    my $self = {};

    # We need to create accessors needed by the create_record()
    # function in parsers. This is an unfortunately dirty way
    # to do this, the list of accessors creeps larger an a different
    # set of fields is passed in during a subsequent instantiation
    foreach my $field (@$fields) {
	no strict "refs"; 
	# We don't want to redefine functions everytime
	# a new instance is created
	next if(defined *{$field});
	*$field = sub :lvalue {
	    my $me = shift;
	    $me->{$field} = shift if @_;
	    $me->{$field};
	};

	*{"get_$field"} = sub {
	    my $me = shift;
	    $me->{$field};
	};

	*{"munge_$field"} = sub {
	    my $me = shift;
	    my $value = shift;
	    $me->{$field} = $value;
	};
    }

    bless $self, $class;

    return $self;
}

=head2 fields

    Description: Accessor/mutator for fields in record type

=cut

sub fields {
    my $self = shift;

    if(@_) {
	my $arg = shift;
	if(ref $arg eq 'ARRAY') {
	    $self->{fields} = $arg;
	}
    } else {
	return $self->{'fields'} || [];
    }
}

1;
