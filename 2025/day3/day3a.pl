#!/usr/bin/perl -Tw

use Modern::Perl;
use List::Util      qw(max);
use List::MoreUtils qw(first_index);
use Data::Dumper;

our $VERSION = '1.0';

my @banks             = <>;
my $total_max_joltage = 0;
foreach my $bank (@banks) {
    my $max_joltage = get_max_joltage($bank);
    print "$bank: $max_joltage\n";
    $total_max_joltage += $max_joltage;
}
print "$total_max_joltage\n";

sub get_max_joltage {
    my ($bank) = @_;

    my @batteries         = split //xlsm, $bank;
    my @find_first_digit  = @batteries[ 0 .. $#batteries - 2 ];
    my $max_first_digit   = max(@find_first_digit);
    my $index_one         = first_index { $_ eq $max_first_digit } @batteries;
    my @find_second_digit = @batteries[ $index_one + 1 .. $#batteries - 1 ];
    my $max_second_digit  = max(@find_second_digit);
    return int ($max_first_digit + $max_second_digit);
}
