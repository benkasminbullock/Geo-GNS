# Check that there are no uncommitted changes and we are on the master
# branch before releasing to CPAN.

use warnings;
use strict;
use FindBin '$Bin';
use Test::More;
use Perl::Build::Git ':all';
my $p = '/home/ben/projects';
my @dirs = ($Bin, "$p/qrduino", "$p/check4libpng");
for my $dir (@dirs) {
    ok (no_uncommited_changes ($dir), "$dir: no uncommited changes");
    ok (branch_is_master ($dir), "$dir: branch is master");
    ok (up_to_date ($dir), "no unpushed changes");
}
done_testing ();
