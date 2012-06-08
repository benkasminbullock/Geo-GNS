=head1 NAME

Geo::GNS::Update - update GNS files from web

=cut
package Geo::GNS::Update;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw//;
use warnings;
use strict;
our $VERSION = 0.01;

# This is the base URL for the downloads.

my $base_url = 'http://earth-info.nga.mil/gns/html/cntyfile';

1;
