#!/usr/bin/perl -Tw

use Modern::Perl;
use Carp;
use List::Util qw(uniq);

our $VERSION = '1.0';

my $input = <>;

my @all_directions = split //xslm, $input;

my @santa_directions;
my @robo_santa_directions;
for my $count ( 0 .. $#all_directions ) {
    if ( $count % 2 == 0 ) {
        push @santa_directions, $all_directions[$count];
    }
    else {
        push @robo_santa_directions, $all_directions[$count];
    }
}

my %santa_delivered_houses      = deliver(@santa_directions);
my %robo_santa_delivered_houses = deliver(@robo_santa_directions);

my @santa_houses      = keys %santa_delivered_houses;
my @robo_santa_houses = keys %robo_santa_delivered_houses;
my @all_houses;
push @all_houses, @santa_houses;
push @all_houses, @robo_santa_houses;
my @houses_delivered_to = uniq @all_houses;

my $number_of_houses = scalar @houses_delivered_to;
print $number_of_houses, "\n";

sub deliver {
    my @directions = @_;

    my %house;
    my $x_position = 0;
    my $y_position = 0;
    my $coordinate = q{};

    $coordinate = sprintf '%d,%d', $x_position, $y_position;
    my $before_count = $house{$coordinate} // 0;
    $house{$coordinate} += 1;

    for my $direction (@directions) {
        $x_position -= ( $direction eq q{<} );
        $x_position += ( $direction eq q{>} );
        $y_position += ( $direction eq q{^} );
        $y_position -= ( $direction eq q{v} );
        if ( $direction !~ /[<^>v]/xlsm ) {
            croak "ELF TOO DRUNK!\n";
        }

        $coordinate   = sprintf '%d,%d', $x_position, $y_position;
        $before_count = $house{$coordinate} // 0;
        $house{$coordinate} += 1;
    }
    return %house;
}
