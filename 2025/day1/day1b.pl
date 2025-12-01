#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;

our $VERSION = '1.0';

my @input             = <>;
my @rotation_commands = map { trim($_) } @input;
my $current_number    = 50;
my $password          = 0;
my $dial_size         = 100;
for my $command (@rotation_commands) {
    my $direction = substr $command, 0, 1;
    my $amount    = substr $command, 1;
    $amount = int $amount;
    if ( $direction eq 'L' ) {
        while ( $amount > 0 ) {
            $current_number -= 1;
            $amount         -= 1;
            $current_number = $current_number % $dial_size;
            if ( $current_number == 0 ) {
                $password += 1;
            }
        }
    }
    if ( $direction eq 'R' ) {
        while ( $amount > 0 ) {
            $current_number += 1;
            $amount         -= 1;
            $current_number = $current_number % $dial_size;
            if ( $current_number == 0 ) {
                $password += 1;
            }
        }
    }
}
print 'Password: ', $password, "\n";
