#!/usr/bin/perl -Tw

use Modern::Perl;
use List::Util qw(uniq max min);

our $VERSION = '1.0';

my @ranges;
my @merged_ranges;
my $new_end;
my $new_start;

my @data = <>;
foreach my $line (@data) {
    chomp $line;
    if ( $line =~ /\d-\d/xlsm ) {
        push @ranges, $line;
    }
}

@merged_ranges = @ranges;
foreach my $index1 ( 0 .. $#merged_ranges ) {
    foreach my $index2 ( 0 .. $#merged_ranges ) {
        if ( $index1 == $index2 ) {
            next;
        }
        my ( $start1, $end1 ) = split /-/xlsm, $merged_ranges[$index1];
        my ( $start2, $end2 ) = split /-/xlsm, $merged_ranges[$index2];
        if ( $start2 <= $start1 && $start1 <= $end2 ) {
            $new_end                = max( $end1, $end2 );
            $merged_ranges[$index1] = sprintf '%s-%s', $start2, $new_end;
            $merged_ranges[$index2] = sprintf '%s-%s', $start2, $new_end;
        }
        if ( $start1 <= $start2 && $start2 <= $end1 ) {
            $new_end                = max( $end1, $end2 );
            $merged_ranges[$index1] = sprintf '%s-%s', $start1, $new_end;
            $merged_ranges[$index2] = sprintf '%s-%s', $start1, $new_end;
        }
        if ( $start2 <= $end1 && $end1 <= $end2 ) {
            $new_start              = min( $start1, $start2 );
            $merged_ranges[$index1] = sprintf '%s-%s', $new_start, $end2;
            $merged_ranges[$index2] = sprintf '%s-%s', $new_start, $end2;
        }
        if ( $start1 <= $end2 && $end2 <= $end1 ) {
            $new_start              = min( $start1, $start2 );
            $merged_ranges[$index1] = sprintf '%s-%s', $new_start, $end1;
            $merged_ranges[$index2] = sprintf '%s-%s', $new_start, $end1;
        }
    }
}

@merged_ranges = uniq @merged_ranges;

my $count = 0;
foreach my $range (@merged_ranges) {
    my ( $start, $end ) = split /-/xlsm, $range;
    $count += $end - $start + 1;
}
print "FRESH INGREDIENT COUNT: $count\n";
