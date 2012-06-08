=head1 NAME

Geo::GNS::Parser

=cut
package Geo::GNS::Parser;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw/$data_dir parse_file/;
use warnings;
use strict;
our $VERSION = 0.01;

our $data_dir = '/home/ben/data/gns';

# See L<http://earth-info.nga.mil/gns/html/gis_countryfiles.html> for
# explanations.

my @fields = qw/RC UFI UNI LAT LONG DMS_LAT DMS_LONG MGRS JOG FC DSG
PC CC1 ADM1 POP ELEV CC2 NT LC SHORT_FORM GENERIC SORT_NAME_RO
FULL_NAME_RO FULL_NAME_ND_RO SORT_NAME_RG FULL_NAME_RG FULL_NAME_ND_RG
NOTE MODIFY_DATE/;

=head2 parse_file

    my $data = parse_file ('ja.txt');

Parse the data in F<ja.txt> and put the lines into an array. The
return value is a reference to the array.

=cut

sub parse_file
{
    my ($file) = @_;
    if ($file !~ m!/!) {
        $file = "$data_dir/$file";
    }
    my @data;
    open my $input, "<:encoding(utf8)", $file or die $!;
    while (<$input>) {
        my @parts = split /\s+/;
        my %line;
        @line{@fields} = @parts;
        my $ufi = $line{UFI};
        push @data, \%line;
    }
    return \@data;
}

1;
