#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

const my $ON          => q{#};
const my $OFF         => q{.};
const my $REPETITIONS => 100;
const my $CHECK_1     => 2;
const my $CHECK_2     => 3;
const my $LEFT        => -1;
const my $UP          => -1;
const my $RIGHT       => 1;
const my $DOWN        => 1;

my %board;
my @input = <>;
my $y_pos = 0;
foreach my $line (@input) {
    chomp $line;
    my $count = length $line;
    my @lines = split //mxls, $line;
    my $x_pos = 0;
    foreach my $value (@lines) {
        $board{$x_pos}{$y_pos} = $value;
        ++$x_pos;
    }
    ++$y_pos;
}

my $board_height = scalar keys %board;
my $board_width  = scalar keys %{ $board{0} };
draw_board(%board);
foreach my $repetition ( 1 .. $REPETITIONS ) {
    %board = process_board(%board);
    draw_board(%board);
}

sub process_board {
    my (%original_board) = @_;

    my %new_board;

    my $height = scalar keys %original_board;
    my $width  = scalar keys %{ $original_board{0} };

    foreach my $y ( 1 .. $height ) {
        foreach my $x ( 1 .. $width ) {
            my $y_index = $y - 1;
            my $x_index = $x - 1;
            my $neighbours_on_count =
              count_neighbours_on( $x_index, $y_index, \%original_board );

            #print "Neighbour count: $neighbours_on_count\n";
            if ( $original_board{$x_index}{$y_index} eq $ON ) {
                if (   $neighbours_on_count == $CHECK_1
                    || $neighbours_on_count == $CHECK_2 )
                {
                    $new_board{$x_index}{$y_index} = $ON;
                }
                else {
                    $new_board{$x_index}{$y_index} = $OFF;
                }
            }
            else {
                if ( $neighbours_on_count == $CHECK_2 ) {
                    $new_board{$x_index}{$y_index} = $ON;
                }
                else {
                    $new_board{$x_index}{$y_index} = $OFF;
                }
            }
        }
    }
    return %new_board;
}

sub count_neighbours_on {
    my ( $x_position, $y_position, $board_to_check ) = @_;

    my %passed_board = %{$board_to_check};

    my $height = scalar keys %passed_board;
    my $width  = scalar keys %{ $passed_board{0} };

    my $neighbours_on_count = 0;
    foreach my $y_delta ( $UP .. $DOWN ) {
        if ( ( $y_position + $y_delta ) < 0 ) {
            next;
        }
        if ( ( $y_position + $y_delta ) > ( $height - 1 ) ) {
            next;
        }
        foreach my $x_delta ( $LEFT .. $RIGHT ) {
            if ( ( $x_position + $x_delta ) < 0 ) {
                next;
            }
            if ( ( $x_position + $x_delta ) > ( $width - 1 ) ) {
                next;
            }
            if ( $y_delta == 0 && $x_delta == 0 ) {
                next;
            }
            if ( $passed_board{ $x_position + $x_delta }
                { $y_position + $y_delta } eq $ON )
            {
                #print "($x_position+$x_delta,$y_position+$y_delta) ON\n";
                ++$neighbours_on_count;
            }
        }
    }
    return $neighbours_on_count;
}

sub draw_board {
    my (%board_to_draw) = @_;

    my $height    = scalar keys %board_to_draw;
    my $width     = scalar keys %{ $board_to_draw{0} };
    my $number_on = 0;

    print "****************\n";
    foreach my $y ( 0 .. $height - 1 ) {
        foreach my $x ( 0 .. $width - 1 ) {
            print $board_to_draw{$x}{$y};
            if ( $board_to_draw{$x}{$y} eq $ON ) {
                $number_on++;
            }
        }
        print "\n";
    }
    print "LIGHTS ON: $number_on\n";
    return;
}
