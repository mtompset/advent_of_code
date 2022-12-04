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

foreach my $ruck_sack (@ruck_sacks) {
    my $compartment_size       = ( length $ruck_sack ) / 2;
    my $compartment_1_contents = substr $ruck_sack, 0, $compartment_size;
    my $compartment_2_contents = substr $ruck_sack, -$compartment_size,
      $compartment_size;
    print "$ruck_sack: $compartment_1_contents $compartment_2_contents\n";
    my @compartment_1 = split //xslm, $compartment_1_contents;
    my @compartment_2 = split //xslm, $compartment_2_contents;
    my @unique_c1     = uniq @compartment_1;
    my @unique_c2     = uniq @compartment_2;
    my @intersection = intersect( @unique_c1, @unique_c2 );
    croak Dumper( \@intersection ) if ( scalar @intersection > 1 );
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
