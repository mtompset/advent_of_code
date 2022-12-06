#!/usr/bin/perl -w

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

my $encoded_length = 0;
my $decoded_length = 0;
my @strings = <>;
foreach my $string (@strings) {
    chomp $string;
    my $decoded_string = eval($string);
    print "$string:$decoded_string\n";
    $encoded_length += length $string;
    $decoded_length += length $decoded_string;
}
print "Full length: $encoded_length\nBytes: $decoded_length\n";
print "Difference: ", $encoded_length - $decoded_length, "\n";
