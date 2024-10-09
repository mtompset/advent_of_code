#!/usr/bin/perl -Tw

use Modern::Perl;
use Algorithm::Permute;
use Data::Dumper;
use Const::Fast;

our $VERSION = '1.0';

const my $GAIN => 1;
const my $LOSS => -1;
my @data   = <>;
my %happiness;

foreach my $line (@data) {
    my $person;
    my $sign;
    my $amount;
    my $neighbour;
    if ($line =~ /(.*)\s\s*would\s\s*(.*)\s\s*(\d\d*)/mxls ) {
        $person = $1;
        $sign = ($2 eq 'gain') ? $GAIN : $LOSS;
        $amount = $3;
    }
    if ($line =~ /sitting\s\s*next\s\s*to\s\s*([^.]*)/mxls ) {
        $neighbour = $1;
    }
    $happiness{$person}{$neighbour} = $sign * $amount;
}

my %order_value;

my @people = keys %happiness;
my $iterator = Algorithm::Permute->new ( \@people );

while (my @permutation = $iterator->next) {
   my $key = join q{-}, @permutation;
   my $calculated_happiness = 0;
   # $#permutation index of last element, scalar @permutation number of elements
   foreach my $count (0..$#permutation) {
       my $before = ($count-1) % (@permutation);
       my $after = ($count+1) % (@permutation);
       $calculated_happiness += $happiness{$permutation[$count]}{$permutation[$before]};
       $calculated_happiness += $happiness{$permutation[$count]}{$permutation[$after]};
   }
   $order_value{$key} = $calculated_happiness;
}

print Dumper(\%order_value);
my $maximum = undef;
foreach my $ordering (keys %order_value) {
    if (! defined $maximum || $order_value{$ordering} > $maximum) {
        $maximum = $order_value{$ordering};
    }
}
print sprintf "Maximum change: %d\n", $maximum;
