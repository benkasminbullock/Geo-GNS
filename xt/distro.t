use warnings;
use strict;
use Test::More;
use FindBin '$Bin';
use Perl::Build qw/get_info/;


# Check that OPTIMIZE is not defined in Makefile.PL.

my $file = "$Bin/../Makefile.PL";
open my $in, "<", $file or die $!;
while (<$in>) {
    if (/-Wall/) {
	like ($_, qr/^\s*#/, "Commented out -Wall in Makefile.PL");
    }
}
close $in or die $!;

my $info = get_info (base => "$Bin/..");
my $name = $info->{name};
my $version = $info->{version};
my $distrofile = "$Bin/../$name-$version.tar.gz";
if (! -f $distrofile) {
    die "No $distrofile";
}
my @tgz = `tar tfz $distrofile`;
my %badfiles;
my %files;
for (@tgz) {
    if (/(\.tmpl|-out\.txt|(?:make-pod|build)\.pl|xt\/.*\.t)$/) {
	$files{$1} = 1;
	$badfiles{$1} = 1;
    }
}
ok (! $files{".tmpl"}, "no templates in distro");
ok (! $files{"-out.txt"}, "no out.txt in distro");
ok (! $files{"make-pod.pl"}, "no make-pod.pl in distro");
ok (! $files{"build.pl"}, "no build.pl in distro");
ok (keys %badfiles == 0, "no bad files");
if (keys %badfiles > 0) {
    note (join (", ", keys %badfiles));
}
done_testing ();
