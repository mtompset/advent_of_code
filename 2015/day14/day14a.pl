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
    $check = $line;
    if ($check =~ /rest\sfor\s(\d\d*)\sseconds[.]/mxls ) {
        $rest = $1;
    }
    $reindeers{$name} = {
        'speed' => $speed,
        'time'  => $time,
        'rest'  => $rest,
    }
}

my @racers = sort keys %reindeers;
foreach my $racer (@racers) {
    my $run_and_rest_iterations = int($RACE_DURATION / ($reindeers{$racer}{'time'} + $reindeers{$racer}{'rest'}));
    my $distance = $run_and_rest_iterations * $reindeers{$racer}{'time'} * $reindeers{$racer}{'speed'};
    my $remainder = $RACE_DURATION - ($run_and_rest_iterations * ($reindeers{$racer}{'time'} + $reindeers{$racer}{'rest'}));
    my $difference = ($remainder >= $reindeers{$racer}{'time'}) ? $reindeers{$racer}{'time'} : $remainder;
    my $delta = $difference * $reindeers{$racer}{'speed'};
#    print "$racer: $reindeers{$racer}{'speed'} : $reindeers{$racer}{'time'} : $reindeers{$racer}{'rest'} : $run_and_rest_iterations: $remainder: $distance: $delta\n";
    print "$racer: ", $distance+$delta, "\n";
}
