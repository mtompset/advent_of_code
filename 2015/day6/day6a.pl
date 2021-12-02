#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;

const my $TOGGLE_COMMAND => -1;
const my $ON_COMMAND     => 1;
const my $OFF_COMMAND    => 0;
const my $UPPER_BOUNDARY => 999;

our $VERSION = '1.0';

my @instructions = <>;
my %light;
foreach my $instruction (@instructions) {
    chomp $instruction;    # deal with line-feed issues
    if ( $instruction =~ /([^\d]*) (\d*),(\d*) .*? (\d*),(\d*)/xlsm ) {
        my $command = trim($1);
        my $x_start = int trim($2);
        my $y_start = int trim($3);
        my $x_end   = int trim($4);
        my $y_end   = int trim($5);
        my $set_value =
            ( lc $command =~ /toggle/xlsm )  ? $TOGGLE_COMMAND
          : ( lc $command =~ /turn on/xlsm ) ? $ON_COMMAND
          :                                    $OFF_COMMAND;
        for my $x_position ( $x_start .. $x_end ) {
            for my $y_position ( $y_start .. $y_end ) {
                my $position      = sprintf '%d,%d', $x_position, $y_position;
                my $initial_value = $light{$position} // 0;
                my $new_value;
                if ( $set_value == $TOGGLE_COMMAND ) {
                    $new_value = $initial_value == 1 ? 0 : 1;
                }
                else {
                    $new_value = $set_value;
                }
                $light{$position} = $new_value;
            }
        }
    }
}

my $number_lit = 0;
for my $x ( 0 .. $UPPER_BOUNDARY ) {
    for my $y ( 0 .. $UPPER_BOUNDARY ) {
        my $position = sprintf '%d,%d', $x, $y;
        my $value    = $light{$position} // 0;
        $number_lit += $value;
    }
}
print "There are $number_lit lights lit.\n";
