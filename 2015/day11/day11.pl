#!/usr/bin/perl -w

use Modern::Perl;
use Data::Dumper;
use Math::Combinatorics;
use English qw( -no_match_vars );
use Const::Fast;

const my $LAST_LETTER_ORDINAL => 26;
our $VERSION = '1.0';
local $OUTPUT_AUTOFLUSH = 1;


my $old_password = <>;
chomp $old_password;
print "Starting with $old_password\n";

my $new_password;
while ($new_password = calculate_next($old_password)) {
    if (is_password_okay($new_password)) {
        print "\nNEW PASSWORD: $new_password\n";
        last;
    } else {
        print "$new_password\n";
        $old_password = $new_password;
    }
}


sub calculate_next {
    my ($string) = @_;

    my @data = split //xslm, $string;
    foreach my $count (0..$#data) {
        $data[$count] = ord($data[$count]) - ord('a');
    }
    $data[$#data] += 1;
    foreach my $count (reverse 0..$#data) {
        if ($data[$count] >= $LAST_LETTER_ORDINAL) {
            $data[$count - 1] += 1;
            $data[$count] = 0;
        }
    }
    foreach my $count (0..$#data) {
        $data[$count] = chr($data[$count] + ord('a'));
    }
    return join q{}, @data;
}

sub is_password_okay {
    my ($string) = @_;

    if (has_three_in_a_row($string) && has_no_iol($string) && has_two_different_nonoverlapping_pairs($string)) {
        return 1;
    } else {
        return 0;
    }
}

sub has_three_in_a_row {
    my ($string) = @_;

    my @data = split //xslm, $string;
    foreach my $count (0..($#data - 2)) {
        my $c1 = $data[$count + 0];
        my $c2 = $data[$count + 1];
        my $c3 = $data[$count + 2];
        if ((ord($c2) - ord($c1)) == 1 && (ord($c3) - ord($c2)) == 1) {
            return 1;
        }
    }
    return 0;
}

sub has_no_iol {
    my ($string) = @_;

    my $stripped = $string;
    $stripped =~ s/[iol]//gmxls;

    if (length $stripped == length $string) {
        return 1;
    } else {
        return 0;
    }
}

sub has_two_different_nonoverlapping_pairs {
    my ($string) = @_;

    my @data = split //xslm, $string;
    my $pair1 = q{};
    my $pair2 = q{};
    # Find first pair
    foreach my $count (0..($#data-1)) {
        my $c1 = $data[$count + 0];
        my $c2 = $data[$count + 1];
        if ($c1 eq $c2) {
            $pair1 = $data[$count];
        }
    }
    # Find last pair
    foreach my $count (reverse 0..($#data-1)) {
        my $c1 = $data[$count + 0];
        my $c2 = $data[$count + 1];
        if ($c1 eq $c2 && $c1 ne $pair1) {
            $pair2 = $data[$count];
        }
    }

    if ($pair1 ne q{} && $pair2 ne q{}) {
        return 1;
    } else {
        return 0;
    }
}
