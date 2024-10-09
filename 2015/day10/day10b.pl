#!/usr/bin/perl -w

use Modern::Perl;
use Data::Dumper;
use Math::Combinatorics;
use Const::Fast;
use English qw(-no_match_vars);

our $VERSION = '1.0';
const my $ITERATIONS => 50;
local $OUTPUT_AUTOFLUSH = 1;

my $sequence = <>;
chomp $sequence;
print "Starting with $sequence\n";

print "01: $sequence\n";
for my $count (1..$ITERATIONS) {
    my $updated_sequence = calculate_next_sequence($sequence);
    print sprintf("%02d: %s\n", $count + 1, $updated_sequence);
    $sequence = $updated_sequence;
}

print sprintf "LENGTH: %d\n", length $sequence;


sub calculate_next_sequence {
    my ($string) = @_;

    if (length $string < 1) {
        return q{};
    }
    my $return_value = q{};
    my @data = split //xslm, $string;
    my $block = shift @data;
    my $count = 1;
    my @description;
    while (my $current = shift @data) {
        if ($current == $block) {
            ++$count;
        } else {
            push @description, sprintf("%d%s", $count, $block);
            $block = $current;
            $count = 1;
        }
    }
    push @description, sprintf("%d%s", $count, $block);
    return join q{}, @description;
}
