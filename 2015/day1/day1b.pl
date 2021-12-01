#!/usr/bin/perl -Tw

use Modern::Perl;
use Const::Fast;

const my $BASEMENT => -1;

our $VERSION = '1.0';

my $input              = <>;
my $instruction_length = length $input;
for my $current_length ( 1 .. $instruction_length ) {
    my $sub_instruction = substr $input, 0, $current_length;
    my $resulting_floor = which_floor($sub_instruction);
    if ( $resulting_floor == $BASEMENT ) {
        print "Position $current_length\n";
        last;
    }
}

sub which_floor {
    my ($data) = @_;
    my $length = length $data;
    $data =~ s/[(]//gxlsm;
    my $length_no_left = length $data;
    my $number_right   = $length_no_left;
    my $number_left    = $length - $number_right;
    my $floor          = $number_left - $number_right;
    return $floor;
}
