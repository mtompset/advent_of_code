#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use integer;
use Data::Dumper;
use Const::Fast;

our $VERSION = '1.0';

my $wires;
my $input;
my $destination;
const my $BIT_LIMIT_DECIMAL => 65_535;
const my $BIT_LIMIT_HEX => 0xFFFF;

my @instructions = <>;
foreach my $instruction (@instructions) {
    $instruction = trim $instruction;
    if ( $instruction =~ /^([^-]*)->(.*)/mxls ) {
        $destination = trim $2;
        $input = trim $1;
        $wires->{$destination} = $input;
    }
}

my @selected_wires = sort keys %{$wires};
#my @selected_wires = qw/a/;
foreach my $selected_wire (@selected_wires) {
    print sprintf "%s: %d\n", $selected_wire, calculate_wire($wires, $selected_wire);
}

sub calculate_wire {
    my ($current_wires, $which_wire) = @_;

    my $value1;
    my $value2;
    my $match1;
    my $match3;
    my $operand;

    $which_wire = trim $which_wire;
    if ( $which_wire =~ /^(\d\d*)$/mxls ) {
        return int($1);
    }

    my $input_value = $current_wires->{$which_wire};
    print "$which_wire: $input_value\n";

    if ( $input_value =~ /NOT (.*)/mxls ) {
        $value1 = calculate_wire($wires, $1);
        $current_wires->{$which_wire} = $BIT_LIMIT_DECIMAL - int($value1);
    } else {
        if ( $input_value =~ /^([^ ]*)\s([^ ]*)\s([^ ]*)$/mxls ) {
            $operand  = trim $2;
            $match1 = $1;
            $match3 = $3;
            $value1 = calculate_wire($current_wires, $match1);
            $value2 = calculate_wire($current_wires, $match3);
            if ($operand eq 'RSHIFT') {
                $current_wires->{$which_wire} = ($value1 >> $value2) & $BIT_LIMIT_HEX;
                print "$which_wire (RSHIFT): ", $current_wires->{$which_wire}, "\n";
            } elsif ($operand eq 'LSHIFT') {
                $current_wires->{$which_wire} = ($value1 << $value2) & $BIT_LIMIT_HEX;
                print "$which_wire (LSHIFT): ", $current_wires->{$which_wire}, "\n";
            } elsif ($operand eq 'AND') {
                $current_wires->{$which_wire} = $value1 & $value2;
                print "$which_wire (AND): $value1 & $value2\n";
            } elsif ($operand eq 'OR') {
                $current_wires->{$which_wire} = $value1 | $value2;
                print "$which_wire (OR): $value1 | $value2\n";
            }
        } else {
            $value1 = calculate_wire($wires, $input_value);
            $current_wires->{$which_wire} = int($value1);
            print "$which_wire (NOP): ", $current_wires->{$which_wire}, "\n";
            return int($value1);
        }
    }
    return calculate_wire($current_wires, $which_wire);
}
