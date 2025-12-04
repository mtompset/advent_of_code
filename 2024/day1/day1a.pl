#!/usr/bin/perl -Tw

use Modern::Perl;
use Text::Trim;
use Carp qw(croak);

our $VERSION = '1.0';

my @input = <>;
my $total = 0;
my @list1;
my @list2;
foreach my $line (@input) {
    if ( $line =~ m/(\d*)\s\s*(\d*)/gxlsm ) {
        push @list1, int $1;
        push @list2, int $2;
    }
}
my @sorted_list1 = sort { $a <=> $b } @list1;
my @sorted_list2 = sort { $a <=> $b } @list2;
if ( $#sorted_list1 != $#sorted_list2 ) {
    croak 'LIST SIZE MISMATCH';
}

while (@sorted_list1) {
    my $first_list  = shift @sorted_list1;
    my $second_list = shift @sorted_list2;
    my $difference  = abs $first_list - $second_list;
    $total += $difference;
}
print "Total difference: $total\n";
