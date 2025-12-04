#!/usr/bin/perl -Tw

use Modern::Perl;
use List::Util               qw(max);
use List::MoreUtils          qw(first_index);
use Algorithm::Combinatorics qw(combinations permutations);
use Data::Dumper;

our $VERSION = '1.0';

my @banks             = <>;
my $total_max_joltage = 0;
foreach my $bank (@banks) {
    chomp $bank;
    my $max_joltage = get_max_joltage($bank);
    $total_max_joltage += $max_joltage;
}
print "$total_max_joltage\n";

sub get_max_joltage {
    my ($bank) = @_;

    my $index;
    my $chosen = substr $bank, -12, 12;
    my $position_in_joltage;
    my $position_in_bank;
    my $current_position;
    my $previous_position = -1;
    my $max_joltage       = $chosen;
    my $joltage;

    for my $index ( 1 .. 12 ) {
        $position_in_joltage = $index - 1;
        $position_in_bank    = ( length $bank ) - ( 12 - $index ) - 1;
        $joltage             = $max_joltage;
        while ($position_in_bank > $previous_position
            && $position_in_bank >= 0 )
        {
#            display_check($bank, $joltage, $position_in_bank, $position_in_joltage);
            substr( $joltage, $position_in_joltage, 1,
                ( substr $bank, $position_in_bank, 1 ) );
            if ( $joltage >= $max_joltage ) {
                $max_joltage      = $joltage;
                $current_position = $position_in_bank;
            }
            --$position_in_bank;
        }
        $previous_position = $current_position;
    }
    return $max_joltage;
}

#sub display_check {
#    my ($full_line, $best_line, $position, $index) = @_;
#    print "$full_line\n";
#    if ($position > 0) { print ' 'x $position; }
#    print "^ $position\n";
#    print "$best_line\n";
#    if ($index > 0) { print ' 'x $index; }
#    print "^ $index\n";
#}
