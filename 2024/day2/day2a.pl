#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Data::Dumper;

our $VERSION = '1.0';

my @reports      = <>;
my $good_reports = 0;
foreach my $report (@reports) {
    $report = trim $report;
    my $check_change = is_all_increasing_or_decreasing($report);
    my $check_gap    = is_difference_between( 1, 3, $report );
    if ( $check_change && $check_gap ) {
        $good_reports++;
    }
}
print "Number of Good Reports: $good_reports\n";

sub is_all_increasing_or_decreasing {
    my ($report) = @_;

    my @levels        = split q{ }, $report;
    my $is_increasing = 0;
    my $is_decreasing = 0;
    for my $index ( 0 .. $#levels - 1 ) {
        my $position1 = $index;
        my $position2 = $index + 1;
        if ( $levels[$position1] > $levels[$position2] ) {
            $is_decreasing = 1;
        }
        if ( $levels[$position1] < $levels[$position2] ) {
            $is_increasing = 1;
        }
    }
    return ( $is_increasing == 1 && $is_decreasing == 0 )
      || ( $is_decreasing == 1 && $is_increasing == 0 );
}

sub is_difference_between {
    my ( $min_diff, $max_diff, $report ) = @_;

    my @levels         = split q{ }, $report;
    my $bad_difference = 0;
    for my $index ( 0 .. $#levels - 1 ) {
        my $position1 = $index;
        my $position2 = $index + 1;
        my $diff      = abs $levels[$position1] - $levels[$position2];
        if ( $min_diff > $diff || $diff > $max_diff ) {
            $bad_difference = 1;
            last;
        }
    }
    return $bad_difference == 1 ? 0 : 1;
}
