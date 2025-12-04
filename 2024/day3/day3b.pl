#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Data::Dumper;
use bigint;

our $VERSION = '1.0';

my @data = <>;
my @muls;
my $mega_line = join q{}, @data;
my $line      = $mega_line;
$line =~ s/[\n\r]//gxlsm;
$line = remove_donts($line);
my @partials = ( $line =~ /(mul[(]\d\d*,\d\d*[)])/gxlsm );
foreach my $partial (@partials) {
    push @muls, $partial;
}
my $total = 0;
foreach my $mul (@muls) {
    if ( $mul =~ /mul[(](\d\d*),(\d\d*)[)]/gxlsm ) {
        my $result = $1 * $2;
        $total += $result;
    }
}
print "Total: $total\n";

sub remove_donts {
    my ($input) = @_;

    my $dos = q{};
    while ( $input =~ /(.*?)don't[(][)](.*?)do[(][)](.*)/gxlsm ) {
        $dos   = sprintf '%s%s', $dos, $1;
        $input = $3;
    }
    if ( $input =~ /(.*?)don't[(][)](.*)/gxlsm ) {
        $dos = sprintf '%s%s', $dos, $1;
    }
    else {
        $dos = sprintf '%s%s', $dos, $input;
    }
    return $dos;
}
