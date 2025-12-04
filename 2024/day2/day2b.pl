#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Data::Dumper;

our $VERSION = '1.0';

my @reports      = <>;
my $good_reports = 0;
foreach my $report (@reports) {
    $report = trim $report;
    $good_reports += problem_dampener($report);
}
print "Number of Good Reports: $good_reports\n";

sub is_good_report {
    my ($report_to_check) = @_;

    my $check_change = is_all_increasing_or_decreasing($report_to_check);
    my $check_gap    = is_difference_between( 1, 3, $report_to_check );
    if ( $check_change && $check_gap ) {
        return 1;
    }
    else {
        return 0;
    }
}

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

sub problem_dampener {
    my ($report) = @_;

    my $good_report = is_good_report($report);
    if ($good_report) {
        return 1;
    }
    my @levels = split q{ }, $report;
    my $index  = 0;
    while ( $index < scalar @levels ) {
        my @revised_levels = @levels;
        splice @revised_levels, $index, 1;
        my $revised_report = ( join q{ }, @revised_levels );
        if ( is_good_report($revised_report) ) {
            return 1;
        }
        $index++;
    }
    return 0;
}
