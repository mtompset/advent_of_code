#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;

our $VERSION = '1.0';
const my $MAX_TOTAL => 100;

my @data   = <>;

my %ingredients;

foreach my $line (@data) {
    my $ingredient_name = qr/(.*):/mxls;
    my $capacity        = qr/capacity\s+([\-]?\d\d*),/mxls;
    my $durability      = qr/durability\s+([\-]?\d\d*),/mxls;
    my $flavor          = qr/flavor\s+([\-]?\d\d*),/mxls;
    my $texture         = qr/texture\s+([\-]?\d\d*),/mxls;
    my $calories        = qr/calories\s+(\d\d*)/mxls;

    # Combining the pieces into the full regex
    if ($line =~ /$ingredient_name\s+$capacity\s+$durability\s+$flavor\s+$texture\s+$calories/mxls) {
        $ingredients{$1} = {
            'capacity'   => $2,
            'durability' => $3,
            'flavor'     => $4,
            'texture'    => $5,
            'calories'   => $6
        };
    }
}

my @mixtures;

# Function to generate combinations
sub generate_combinations {
    my ($n, $sum, @current_combination) = @_;

    # If we have reached the final item, set its value to the remaining sum
    if ($n == 1) {
        push @current_combination, $sum;
        push @mixtures, join q{,}, @current_combination;
        return;
    }

    # Iterate over all possible values for the current item (from 0 to the sum left)
    foreach my $i (0..$sum) {
        generate_combinations($n - 1, $sum - $i, @current_combination, $i);
    }
    return;
}

# Example usage
my $n = scalar keys %ingredients;  # Number of items

generate_combinations($n, $MAX_TOTAL);

my @scores;
my @ingredient_list = sort keys %ingredients;
foreach my $mixture (@mixtures) {
    my $rating_total = 1;
    foreach my $rating (sort keys %{$ingredients{$ingredient_list[0]}}) {
        if ($rating eq 'calories') {
            next;
        }
        my $rating_subtotal = 0;
        my @quantities = split /,/mxls, $mixture;
        my $ingredient_number = 0;
        foreach my $quantity (@quantities) {
            my $score = $ingredients{$ingredient_list[$ingredient_number]}{$rating};
            $rating_subtotal += $score * $quantity;
            ++$ingredient_number;
        }
        if ($rating_subtotal < 0) {
            $rating_subtotal = 0;
        }
        $rating_total = $rating_total * $rating_subtotal;
    }
    push @scores, $rating_total;
}

my $max = 0;
foreach my $count (0..@scores-1) {
    if ($scores[$count] > $scores[$max]) {
        $max = $count;
    }
}

print $mixtures[$max], q{ }, $scores[$max], q{ }, join q{,}, @ingredient_list, "\n";
