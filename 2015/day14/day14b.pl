#!/usr/bin/perl -Tw

use Modern::Perl;
use Data::Dumper;
use Const::Fast;

our $VERSION = '1.0';

my @data   = <>;
my %reindeers;
const my $RACE_DURATION => 2503;

foreach my $line (@data) {
    my $name;
    my $speed;
    my $time;
    my $rest;
    my $check;
    $check = $line;
    if ($check =~ /(.*)\scan\sfly\s(\d\d*)\skm\/s\sfor\s(\d\d*)\sseconds,/mxls ) {
        $name = $1;
        $speed = $2;
        $time = $3;
    }
    if ($check =~ /must\srest\sfor\s(\d\d*)\sseconds[.]/mxls ) {
        $rest = $1;
    }
    $reindeers{$name} = {
        'speed' => $speed,
        'time'  => $time,
        'rest'  => $rest,
    }
}

#print Dumper(\%reindeers);
my @racers = sort keys %reindeers;
my %score;
foreach my $racer (@racers) {
    $score{$racer} = 0;
}
foreach my $current_second (1..$RACE_DURATION) {
    my %current_distance;
    my $max_distance = 0;
    foreach my $racer (@racers) {
        $current_distance{$racer} = how_far($racer, $current_second);
        if ($current_distance{$racer} >= $max_distance) {
            $max_distance = $current_distance{$racer};
        }
    }
    # because more than one reindeer could have the same max distance
    foreach my $racer (@racers) {
        if ($current_distance{$racer} == $max_distance) {
            $score{$racer} += 1;
        }
    }
}
print Dumper(\%score), "\n";

sub how_far {
    my ($racer, $duration) = @_;

    my $run_and_rest_iterations = int($duration / ($reindeers{$racer}{'time'} + $reindeers{$racer}{'rest'}));
    my $distance = $run_and_rest_iterations * $reindeers{$racer}{'time'} * $reindeers{$racer}{'speed'};
    my $remainder = $duration - ($run_and_rest_iterations * ($reindeers{$racer}{'time'} + $reindeers{$racer}{'rest'}));
    my $difference = ($remainder >= $reindeers{$racer}{'time'}) ? $reindeers{$racer}{'time'} : $remainder;
    my $delta = $difference * $reindeers{$racer}{'speed'};
    return $distance+$delta;
}
