#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

my @data   = <>;

my %properties = (
    'children' => 3,
    'cats' => 7,
    'samoyeds' => 2,
    'pomeranians' => 3,
    'akitas' => 0,
    'vizslas' => 0,
    'goldfish' => 5,
    'trees' => 3,
    'cars' => 2,
    'perfumes' => 1
);

my %aunt_properties;

foreach my $line (@data) {
    my $aunt;
    my $check;
    $check = $line;
    if ($check =~ /^Sue\s(\d\d*)/mxls ) {
        $aunt = $1;
    } else {
        print "AUNT NOT FOUND ON $line\n";
        continue;
    }
    foreach my $property (sort keys %properties) {
        $check = $line;
        if ($check =~ /$property:\s(\d\d*)/mxls ) {
            $aunt_properties{$aunt}{$property} = $1;
        }
    }
}

foreach my $aunt_number (sort keys %aunt_properties) {
    my $matches = 1;
    foreach my $property (sort keys %{$aunt_properties{$aunt_number}}) {
        my $check_value = $aunt_properties{$aunt_number}{$property};
        if ($properties{$property} == $check_value) {
            next;
        }
        $matches = 0;
        last;
    }
    if ($matches == 1) {
        print "Aunt Sue $aunt_number:\n";
        print Dumper($aunt_properties{$aunt_number});
        print "\n", Dumper(\%properties), "\n";
    }
}
