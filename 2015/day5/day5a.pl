#!/usr/bin/perl -Tw

use Modern::Perl;
use Data::Dumper;

my @input = <>;
my @words;
foreach my $line (@input) {
    chomp $line;
    push @words, $line;
}

my $naughty_count = 0;
my $number_of_words = scalar @words;
for my $word (@words) {
    print "$word -- ", is_naughty($word), "\n";
    print "*******\n";
    $naughty_count += is_naughty($word);
    print "*******\n";
}
my $nice_count = $number_of_words - $naughty_count;
print "There are $nice_count nice words.\n";

sub is_naughty {
    my ($word) = @_;

    if ($word =~ /ab/gxlsm) {
        print "AB ";
        return 1;
    }
    if ($word =~ /cd/gxlsm) {
        print "CD ";
        return 1;
    }
    if ($word =~ /pq/gxlsm) {
        print "PQ ";
        return 1;
    }
    if ($word =~ /xy/gxlsm) {
        print "XY ";
        return 1;
    }
    if (has_three_vowels($word) == 0) {
        print "3V ";
        return 1;
    }
    my @characters = split //, $word;
    for my $position (1 .. scalar @characters - 1) {
        my $character = $characters[$position - 1];
        my $next_character = $characters[$position];
        if ($character eq $next_character) {
            return 0;
        }
    }
    print "XX ";
    return 1;
}

sub has_three_vowels {
    my ($word) = @_;

    my $before_length = length $word;
    $word =~ s/[aeiou]//gxslm;
    my $after_length = length $word;
    print $before_length, "###", $after_length, "\n";
    if ($before_length - $after_length >= 3) {
        return 1;
    } else {
        return 0;
    }
}
