#!/usr/bin/perl -w

use Modern::Perl;
use Text::Trim;
use Const::Fast;
use Data::Dumper;

our $VERSION = '1.0';

my $coded_length = 0;
my $encoded_length = 0;
my @strings = <>;
foreach my $string (@strings) {
    chomp $string;
    my $encoded_string = $string;
    $encoded_string =~ s/\\/\\\\/gxlsm;
    $encoded_string =~ s/"/\\"/gxlsm;
    $encoded_string = sprintf '"%s"', $encoded_string;
    print "$string:$encoded_string\n";
    $coded_length += length $string;
    $encoded_length += length $encoded_string;
}
print "Full length: $coded_length\nBytes: $encoded_length\n";
print "Difference: ", $encoded_length - $coded_length, "\n";
