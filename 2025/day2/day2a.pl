#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use List::Util qw(sum0);
use Data::Dumper;

our $VERSION = '1.0';

my $input = <>;
chomp $input;
my @ranges = split /,/xlsm, $input;
my @all_invalid_ids;
foreach my $range (@ranges) {
    my @invalid_ids = get_invalid_ids($range);
    push @all_invalid_ids, @invalid_ids;
}
my @ids               = map { int } @all_invalid_ids;
my $total_invalid_ids = sum0(@ids);
print "The sum of invalid ids is: $total_invalid_ids\n";

sub get_invalid_ids {
    my ($string_range) = @_;
    my @range          = split /-/xlsm, $string_range;
    my @range_ids      = map { int } @range;
    my @invalid;

    foreach my $id ( $range_ids[0] .. $range_ids[1] ) {
        my $string_id = sprintf '%s', $id;
        if ( ( length $string_id ) % 2 == 0 ) {
            my $length = ( length $string_id ) / 2;
            my $start  = substr $string_id, 0, $length;
            my $end    = substr $string_id, $length, $length;
            if ( $start eq $end ) {
                push @invalid, $string_id;
            }
        }
    }
    return @invalid;
}
