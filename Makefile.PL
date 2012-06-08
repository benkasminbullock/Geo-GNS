use strict;
use warnings;
use ExtUtils::MakeMaker;

my $pm = 'lib/Geo/GNS.pm';
my $repo = 'https://github.com/benkasminbullock/Geo-GNS';

WriteMakefile (
    NAME => 'Geo::GNS',
    VERSION_FROM => $pm,
    ABSTRACT_FROM => $pm,
    AUTHOR => 'Ben Bullock <bkb@cpan.org>',
    LICENSE => 'perl',
    PREREQ_PM => {
    },
    META_MERGE => {
        resources => {
            repository => $repo,
            bugtracker => "$repo/issues",
        },
    },
);
