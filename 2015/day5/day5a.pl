#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;

our $VERSION = '1.0';

const my $NUMBER_OF_VOWELS => 3;

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

    if ( $word =~ /ab/gxlsm ) {
        return 1;
    }
    if ( $word =~ /cd/gxlsm ) {
        return 1;
    }
    if ( $word =~ /pq/gxlsm ) {
        return 1;
    }
    if ( $word =~ /xy/gxlsm ) {
        return 1;
    }
    if ( has_three_vowels($word) == 0 ) {
        return 1;
    }
    my @characters = split //xlsm, $word;
    for my $position ( 1 .. scalar @characters - 1 ) {
        my $character      = $characters[ $position - 1 ];
        my $next_character = $characters[$position];
        if ( $character eq $next_character ) {
            return 0;
        }
    }
    return 1;
}

sub has_three_vowels {
    my ($word) = @_;

    my $before_length = length $word;
    $word =~ s/[aeiou]//gxslm;
    my $after_length = length $word;
    if ( $before_length - $after_length >= $NUMBER_OF_VOWELS ) {
        return 1;
    }
    else {
        return 0;
    }
}
