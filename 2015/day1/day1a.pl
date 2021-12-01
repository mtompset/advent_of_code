#!/usr/bin/perl -Tw

use Modern::Perl;

our $VERSION = '1.0';

my $data   = <>;
my $length = length $data;
$data =~ s/[(]//gxlsm;
my $length_no_left = length $data;
my $number_right   = $length_no_left;
my $number_left    = $length - $number_right;
my $floor          = $number_left - $number_right;
print "$floor\n";
