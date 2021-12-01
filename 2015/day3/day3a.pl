#!/usr/bin/perl -Tw

use Modern::Perl;
use Carp;

our $VERSION = '1.0';

my $input = <>;

my %house;
my $x_position = 0;
my $y_position = 0;
my $coordinate = q{};

$coordinate = sprintf '%d,%d', $x_position, $y_position;
my $before_count = $house{$coordinate} // 0;
$house{$coordinate} += 1;
my @directions = split //xslm, $input;
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

my @houses           = keys %house;
my $number_of_houses = scalar @houses;
print $number_of_houses, "\n";
