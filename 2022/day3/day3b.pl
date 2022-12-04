#!/usr/bin/perl -Tw

use Modern::Perl;
use Array::Utils qw(:all);
use List::MoreUtils qw(uniq);
use Data::Dumper;
use Carp qw(croak);

our $VERSION = '1.0';

my @ruck_sacks;
my $data;
my $priority_total = 0;
while ( $data = <> ) {
    $data =~ s/^\s+|\s+$//xslmg;
    if ( length $data > 0 ) {
        push @ruck_sacks, $data;
    }
}

while ( scalar @ruck_sacks > 0 ) {
    my $ruck_sack_1  = shift @ruck_sacks;
    my $ruck_sack_2  = shift @ruck_sacks;
    my $ruck_sack_3  = shift @ruck_sacks;
    my @sack_1       = split //xslm, $ruck_sack_1;
    my @sack_2       = split //xslm, $ruck_sack_2;
    my @sack_3       = split //xslm, $ruck_sack_3;
    my @unique_s1    = uniq @sack_1;
    my @unique_s2    = uniq @sack_2;
    my @unique_s3    = uniq @sack_3;
    my @intersect1   = intersect( @unique_s1, @unique_s2 );
    my @intersection = intersect( @intersect1, @unique_s3 );
    croak Dumper( \@intersection ) if ( scalar @intersection > 1 );
    print "$ruck_sack_1\n$ruck_sack_2\n$ruck_sack_3\n$intersection[0]\n\n";
    my $priority = calculate_priority( $intersection[0] );
    $priority_total += $priority;
}
print "Priority Total: $priority_total\n";

sub calculate_priority {
    my ($item_type) = @_;

    my $priority_map = {
        'a' => 1,
        'b' => 2,
        'c' => 3,
        'd' => 4,
        'e' => 5,
        'f' => 6,
        'g' => 7,
        'h' => 8,
        'i' => 9,
        'j' => 10,
        'k' => 11,
        'l' => 12,
        'm' => 13,
        'n' => 14,
        'o' => 15,
        'p' => 16,
        'q' => 17,
        'r' => 18,
        's' => 19,
        't' => 20,
        'u' => 21,
        'v' => 22,
        'w' => 23,
        'x' => 24,
        'y' => 25,
        'z' => 26,
        'A' => 27,
        'B' => 28,
        'C' => 29,
        'D' => 30,
        'E' => 31,
        'F' => 32,
        'G' => 33,
        'H' => 34,
        'I' => 35,
        'J' => 36,
        'K' => 37,
        'L' => 38,
        'M' => 39,
        'N' => 40,
        'O' => 41,
        'P' => 42,
        'Q' => 43,
        'R' => 44,
        'S' => 45,
        'T' => 46,
        'U' => 47,
        'V' => 48,
        'W' => 49,
        'X' => 50,
        'Y' => 51,
        'Z' => 52
    };
    return $priority_map->{$item_type} // 0;
}
