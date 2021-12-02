#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;

our $VERSION = '1.0';

const my $SIZE_OF_PAIR => 2;

my @input = <>;
my @words;
foreach my $line (@input) {
    chomp $line;
    push @words, $line;
}

my $naughty_count   = 0;
my $number_of_words = scalar @words;
for my $word (@words) {
    $naughty_count += is_naughty($word);
}
my $nice_count = $number_of_words - $naughty_count;
print "There are $nice_count nice words.\n";

sub is_naughty {
    my ($word) = @_;

    my $rule1_result = has_non_overlapping_pairs($word);
    my $rule2_result = has_repeating_letter_with_one_gap($word);
    if ($rule1_result + $rule2_result > 1) {
        return 0;
    } else {
        return 1;
    }
}

sub has_repeating_letter_with_one_gap {
    my ($word) = @_;

    my @characters = split //xlsm, $word;
    for my $position ( 2 .. scalar @characters - 1 ) {
        my $initial_character = $characters[ $position - 2 ];
        my $third_character = $characters[$position];
        if ($initial_character eq $third_character) {
            return 1;
        }
    }
    return 0;
}

sub has_non_overlapping_pairs {
    my ($word) = @_;

    my $before_length = length $word;
    my @characters = split //xlsm, $word;
    for my $position ( 1 .. scalar @characters - 1 ) {
        my $pair = sprintf '%s%s', $characters[ $position - 1 ], $characters[$position];
        my $altered_word = $word;
        $altered_word =~ s/${pair}//gxslm;
        my $after_length = length $altered_word;
        if ($before_length - $after_length > $SIZE_OF_PAIR) {
            return 1;
        }
    }
    return 0;
}
