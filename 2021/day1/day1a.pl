#!/usr/bin/perl -Tw

use Modern::Perl;

our $VERSION = '1.0';

my @data                  = <>;
my $number_of_data_points = scalar @data;
my $number_of_increases   = 0;
for my $counter ( 1 .. $number_of_data_points - 1 ) {
    if ( $data[$counter] > $data[ $counter - 1 ] ) {
        $number_of_increases += 1;
    }
}
print "Number of increases: $number_of_increases\n";
