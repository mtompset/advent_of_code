#!/usr/bin/perl -Tw

use Modern::Perl;
use List::Util qw(min);
use Data::Dumper;
use Text::Trim;

our $VERSION = '1.0';

my @input              = <>;
my @box_dimensions     = map { trim($_) } @input;
my $total_paper_needed = 0;
for my $dimension_string (@box_dimensions) {
    my ( $length, $width, $height ) = split_dimensions($dimension_string);
    my $paper_needed = required_paper( $length, $width, $height );
    $total_paper_needed += $paper_needed;
}
print "$total_paper_needed\n";

sub required_paper {
    my ( $length, $width, $height ) = @_;

    my $side1          = $length * $width;
    my $side2          = $length * $height;
    my $side3          = $width * $height;
    my $smallest_side  = min( $side1, $side2, $side3 );
    my $surface_area   = 2 * ( $side1 + $side2 + $side3 );
    my $required_paper = $surface_area + $smallest_side;
    return $required_paper;
}

sub split_dimensions {
    my ($dimension_string) = @_;

    my @split_dimensions = split /x/xlsm, $dimension_string;
    return @split_dimensions;
}
