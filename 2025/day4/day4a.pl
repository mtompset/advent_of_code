#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

const my $TOILET_PAPER => q{@};
const my $EMPTY        => q{ };
const my $PROCESSABLE  => q{x};
const my $LEFT         => -1;
const my $UP           => -1;
const my $RIGHT        => 1;
const my $DOWN         => 1;
const my $MOVABLE      => 4;

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
my $start        = draw_board(%board);
%board = process_board(%board);
my $end = draw_board(%board);
print 'PROCESSABLE ROLLS: ', $start - $end, "\n";

sub process_board {
    my (%original_board) = @_;

    my %new_board;

    my $height = scalar keys %original_board;
    my $width  = scalar keys %{ $original_board{0} };

    foreach my $y ( 1 .. $height ) {
        foreach my $x ( 1 .. $width ) {
            my $y_index = $y - 1;
            my $x_index = $x - 1;
            my $neighbours_count =
              count_neighbours( $x_index, $y_index, \%original_board );

            if ( $neighbours_count < $MOVABLE ) {
                $new_board{$x_index}{$y_index} = $PROCESSABLE;
            }
            else {
                $new_board{$x_index}{$y_index} =
                  $original_board{$x_index}{$y_index};
            }
        }
    }
    return %new_board;
}

sub count_neighbours {
    my ( $x_position, $y_position, $board_to_check ) = @_;

    my %passed_board = %{$board_to_check};

    my $height = scalar keys %passed_board;
    my $width  = scalar keys %{ $passed_board{0} };

    my $neighbours_count = 0;
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
                { $y_position + $y_delta } eq $TOILET_PAPER )
            {
                ++$neighbours_count;
            }
        }
    }
    return $neighbours_count;
}

sub draw_board {
    my (%board_to_draw) = @_;

    my $height = scalar keys %board_to_draw;
    my $width  = scalar keys %{ $board_to_draw{0} };
    my $number = 0;

    print "****************\n";
    foreach my $y ( 0 .. $height - 1 ) {
        foreach my $x ( 0 .. $width - 1 ) {
            print $board_to_draw{$x}{$y};
            if ( $board_to_draw{$x}{$y} eq $TOILET_PAPER ) {
                $number++;
            }
        }
        print "\n";
    }
    print "TOTAL NUMBER OF ROLLS: $number\n";
    return $number;
}
