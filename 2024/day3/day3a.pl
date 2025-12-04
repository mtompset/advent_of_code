#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Data::Dumper;

our $VERSION = '1.0';

my @data = <>;
my @muls;
foreach my $line (@data) {
    my @partials = $line =~ /mul[(]\d+,\d+[)]/gmxls;
    foreach my $partial (@partials) {
        push @muls, $partial;
    }
}
my $total = 0;
foreach my $mul (@muls) {
    if ( $mul =~ /mul[(](\d*),(\d*)[)]/gmxls ) {
        my $result = $1 * $2;
        $total += $result;
    }
}
print "Total: $total\n";
