#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;
use bigint;

our $VERSION = '1.0';

my $row;
my $column;
my $coordinates = <>;
if ( $coordinates =~ /.*?row\s(\d\d*).*?column\s(\d\d*)/xslm ) {
    $row = $1;
    $column = $2;
} else {
    die "KABOOM!\n";
}
my $calculate_diagonal = $row + $column - 1;
my $cd = $calculate_diagonal;
my $calculate_position = ($cd * $cd - $cd + 2) / 2 + $column - 1;
print "$row,$column = ";
print "$calculate_position\n";

my $position = 1;
my $value = 20151125;
while ($position < $calculate_position) {
    ++$position;
    $value = ($value * 252533) % 33554393;
    if ($position % 1000 == 0) {
        print "$position / $calculate_position\n"
    } else {
        print ".";
    }
}    
print "$value\n";
