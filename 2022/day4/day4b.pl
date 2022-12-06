#!/usr/bin/perl -Tw

use Modern::Perl;
use Array::Utils qw(:all);
use List::MoreUtils qw(uniq);
use Data::Dumper;
use Carp qw(croak);

our $VERSION = '1.0';

my $data;
my @section_pairs;
while ( $data = <> ) {
    $data =~ s/^\s+|\s+$//xslmg;
    if ( length $data > 0 ) {
        push @section_pairs, $data;
    }
}

my $count_overlaps = 0;
foreach my $section_pair (@section_pairs) {
    if ( $section_pair =~ /(.*),(.*)/xlsm ) {
        my $section1 = $1;
        my $section2 = $2;
        my $section1_s;
        my $section1_e;
        my $section2_s;
        my $section2_e;
        if ( $section1 =~ /(.*)-(.*)/xlsm ) {
            $section1_s = int $1;
            $section1_e = int $2;
        }
        if ( $section2 =~ /(.*)-(.*)/xlsm ) {
            $section2_s = int $1;
            $section2_e = int $2;
        }
        my $overlaps =
          is_one_section_in_another_partially( $section1_s, $section1_e,
            $section2_s, $section2_e );
        $count_overlaps += $overlaps;
    }
    else {
        croak "Failed to find a pair for $section_pair\n";
    }
}
print 'Total overlaps: ', $count_overlaps, "\n";

sub is_one_section_in_another_partially {
    my ( $s1s, $s1e, $s2s, $s2e ) = @_;

    if ( $s1s <= $s2s && $s2s <= $s1e ) {
        return 1;
    }
    if ( $s1s <= $s2e && $s2e <= $s1e ) {
        return 1;
    }
    if ( $s2s <= $s1s && $s1s <= $s2e ) {
        return 1;
    }
    if ( $s2s <= $s1e && $s1e <= $s2e ) {
        return 1;
    }
    return 0;
}
