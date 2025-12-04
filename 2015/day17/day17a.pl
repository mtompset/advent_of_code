#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

const my $LITERS => 150;
my @sizes;
my @data = <>;

foreach my $line (@data) {
    chomp $line;
    push @sizes, int $line;
}

my @solutions;
my $permutations = 2**@sizes;
foreach my $count ( 1 .. $permutations ) {
    my @multiply_vector = calculate_vector( $count - 1, scalar @sizes );
    my $total           = 0;
    foreach my $index ( 0 .. $#multiply_vector ) {
        $total = $total + $multiply_vector[$index] * $sizes[$index];
    }
    if ( $total == $LITERS ) {
        push @solutions, \@multiply_vector;
    }
}
print 'Total ways: ', scalar @solutions, "\n";

sub calculate_vector {
    my ( $number, $width ) = @_;

    my $binary_string = sprintf "%0${width}b", $number;
    my @vector        = split //mxls, $binary_string;
    return @vector;
}
