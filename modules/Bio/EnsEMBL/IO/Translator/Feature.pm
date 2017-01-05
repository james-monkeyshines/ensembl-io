=pod

=head1 LICENSE

Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

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

Translator::Feature - parent class for other API objects 

=cut

package Bio::EnsEMBL::IO::Translator::Feature;

use strict;
use warnings;

use Carp;

use base qw/Bio::EnsEMBL::IO::Translator/;

=head2 get_seqname

    Description: Wrapper around API call to seq region name
    Returntype : String

=cut

sub get_seqname {
  my ($self, $feature) = @_;
  return $feature->slice->seq_region_name;
}

=head2 get_start

    Description: Wrapper around API call to feature start
    Returntype : Integer

=cut

sub get_start {
  my ($self, $feature) = @_;
  return $feature->start;
}

=head2 get_end

    Description: Wrapper around API call to feature end
    Returntype : Integer

=cut

sub get_end {
  my ($self, $feature) = @_;
  return $feature->end;
}

=head2 get_name

    Description: Wrapper around API call to feature name
    Returntype : String

=cut

sub get_name {
  my ($self, $feature) = @_;
  return $feature->stable_id;
}

=head2 get_score

    Description: Stub - most features don't have a score
    Returntype : String

=cut

sub get_score {}

=head2 get_strand

    Description: Wrapper around API call to feature strand
    Returntype : String

=cut

sub get_strand {
  my ($self, $feature) = @_;
  return $feature->strand;
}

1;
