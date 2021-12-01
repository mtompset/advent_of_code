#!/usr/bin/perl -Tw

use Modern::Perl;

our $VERSION = '1.0';

my @input                 = <>;
my @data                  = convert_to_truple_sums(@input);
my $number_of_data_points = scalar @data;
my $number_of_increases   = 0;
for my $counter ( 1 .. $number_of_data_points - 1 ) {
    if ( $data[$counter] > $data[ $counter - 1 ] ) {
        $number_of_increases += 1;
    }
}
print "Number of increases: $number_of_increases\n";

sub convert_to_truple_sums {
    my @initial_data = @_;

    my @trupled_data;
    my $data_size = scalar @initial_data;
    for my $counter ( 2 .. $data_size - 1 ) {
        push @trupled_data,
          $initial_data[ $counter - 2 ] +
          $initial_data[ $counter - 1 ] +
          $initial_data[$counter];
    }
    return @trupled_data;
}
