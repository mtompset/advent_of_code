#!/usr/bin/perl -w

use Modern::Perl;
use Data::Dumper;
use Math::Combinatorics;
use Carp qw(croak);

our $VERSION = '1.0';

my %distances;
my @measurements = <>;
foreach my $measurement (@measurements) {
    chomp $measurement;
    if ( $measurement =~ /(.*?)\s*to\s*(.*?)\s*= (.*)/xslm ) {
        my $source = $1;
        my $destination = $2;
        my $distance = int($3);
        print "$source to $destination = $distance\n";
        $distances{$source}{$destination} = $distance;
        $distances{$destination}{$source} = $distance;
    } else {
        croak "KABOOM!";
    }
}


my @locations = sort keys %distances;
print Dumper(\@locations);
print Dumper(\%distances);

my $combinations = Math::Combinatorics->new(
    count => $#locations + 1,
    data => [@locations]
);

my @smallest_path;
my $minimum_path = 0;
while (my @path = $combinations->next_permutation) {
    my $path_length = 0;
    foreach my $position (1 .. $#path) {
        my $source = $path[$position - 1];
        my $destination = $path[$position];
        $path_length += $distances{$source}{$destination};
    }
    if ($minimum_path == 0) {
        $minimum_path = $path_length;
        @smallest_path = @path;
    } elsif ($path_length < $minimum_path) {
        $minimum_path = $path_length;
        @smallest_path = @path;
    }
    print join(q{ }, @path), ": $path_length\n";
}

print join(q{ }, @smallest_path), ": $minimum_path\n";
