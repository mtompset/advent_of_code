#!/usr/bin/perl -Tw

use Modern::Perl;

our $VERSION = '1.0';

my @data = <>;
my @ranges;
my @ingredients;
foreach my $line (@data) {
    chomp $line;
    if ( $line =~ /\d-\d/xlsm ) {
        push @ranges, $line;
    }
    if ( $line =~ /^\d\d*$/xlsm ) {
        push @ingredients, $line;
    }
}

my $fresh_ingredient_count = 0;
foreach my $ingredient (@ingredients) {
    my $fresh = is_fresh( $ingredient, @ranges );
    if ($fresh) {
        ++$fresh_ingredient_count;
    }
}
print "There are $fresh_ingredient_count fresh ingredients\n";

sub is_fresh {
    my ( $ingredient, @fresh_ranges ) = @_;

    my $fresh = 0;
    foreach my $fresh_range (@fresh_ranges) {
        my ( $start, $end ) = split /-/xlsm, $fresh_range;
        if ( $start <= $ingredient && $ingredient <= $end ) {
            $fresh = 1;
            last;
        }
    }
    return $fresh;
}
