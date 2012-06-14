=head1 NAME

Geo::GNS::Parser - parse a GNS data file

=cut
package Geo::GNS::Parser;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw/$data_dir parse_file/;
use warnings;
use strict;
use Carp;
our $VERSION = 0.01;

our $data_dir = '/home/ben/data/gns';

# See L<http://earth-info.nga.mil/gns/html/gis_countryfiles.html> for
# explanations.

my @fields = qw/RC UFI UNI LAT LONG DMS_LAT DMS_LONG MGRS JOG FC DSG
PC CC1 ADM1 POP ELEV CC2 NT LC SHORT_FORM GENERIC SORT_NAME_RO
FULL_NAME_RO FULL_NAME_ND_RO SORT_NAME_RG FULL_NAME_RG FULL_NAME_ND_RG
NOTE MODIFY_DATE/;

=head2 parse_file

    parse_file (file => 'ja.txt', data => \@array);

Parse the data in the file specified by C<file> and put the lines into
the array specified by the C<data> parameter.

    parse_file (file => 'af.txt', callback => \& myroutine);

Parse the data in the file specified by C<file>. As each line of data
is parsed, call back the code routine specified by C<callback>. The callback is called in the form

    &{callback} (undef, \%line);

Possible options are

=over

=item file

The file name. This must be supplied or the module dies.

=item data

An array reference.

=item callback

A code reference to call back. If parse_file is called as

    parse_file (%inputs);

then the callback is called in the form

    &{$inputs{callback}} ($inputs{callback_data}, \%line);

where C<%line> is a hash containing the parts of the line.

=item callback_data

User-specified data to pass to the callback routine. See callback above.

=back

=cut

sub parse_file
{
    my (%options) = @_;
    my $file = $options{file};
    my $data = $options{data};
    my $callback = $options{callback};
    my $callback_data = $options{callback_data};
    if (! $file) {
        croak "Specify a file with 'file =>'";
    }
    if ($file !~ m!/!) {
        $file = "$data_dir/$file";
    }
    open my $input, "<:encoding(utf8)", $file or die $!;
    while (<$input>) {
        my @parts = split /\t/;
        if (@parts != 29) {
            die "$file:$.: bad line containing " . scalar (@parts) . " parts.\n";
        }
        my %line;
        @line{@fields} = @parts;
        my $ufi = $line{UFI};
        if ($callback) {
            &{$callback} ($callback_data, \%line);
        }
        if ($data) {
            push @$data, \%line;
        }
    }
    close $input or die $!;
}

1;
