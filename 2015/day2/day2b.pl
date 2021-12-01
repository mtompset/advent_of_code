#!/usr/bin/perl -Tw

use Modern::Perl;
use List::Util qw(min);
use Data::Dumper;
use Text::Trim;

our $VERSION = '1.0';

my @input              = <>;
my @box_dimensions     = map { trim($_) } @input;
my $total_ribbon_needed = 0;
for my $dimension_string (@box_dimensions) {
    my ( $length, $width, $height ) = split_dimensions($dimension_string);
    my $ribbon_needed = required_ribbon( $length, $width, $height );
    $total_ribbon_needed += $ribbon_needed;
}
print "$total_ribbon_needed\n";

sub required_ribbon {
    my ( $length, $width, $height ) = @_;

    my $side1          = 2 * $length + 2 * $width;
    my $side2          = 2 * $length + 2 * $height;
    my $side3          = 2 * $width  + 2 * $height;
    my $smallest_side  = min( $side1, $side2, $side3 );
    my $extra_for_bow  = $length * $width * $height;
    my $required_ribbon = $smallest_side + $extra_for_bow;
    return $required_ribbon;
}

sub split_dimensions {
    my ($dimension_string) = @_;

    my @split_dimensions = split /x/xlsm, $dimension_string;
    return @split_dimensions;
}
