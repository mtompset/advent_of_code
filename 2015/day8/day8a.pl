#!/usr/bin/perl -w

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;
use String::Interpolate qw(interpolate);

our $VERSION = '1.0';

const my $SECOND_LAST_STRING_POSITION => -1;
my $encoded_length = 0;
my $decoded_length = 0;
my @strings = <>;
foreach my $string (@strings) {
    chomp $string;
    # Like an eval $string, but puts quotes around it
    my $decoded_string = interpolate($string);
    # remove the quotes
    $decoded_string = substr($decoded_string, 1, $SECOND_LAST_STRING_POSITION);
    print "$string:$decoded_string\n";
    $encoded_length += length $string;
    $decoded_length += length $decoded_string;
}
print "Full length: $encoded_length\nBytes: $decoded_length\n";
print "Difference: ", $encoded_length - $decoded_length, "\n";
