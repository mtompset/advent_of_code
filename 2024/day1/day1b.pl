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
if ( $#list1 != $#list2 ) {
    croak 'LIST SIZE MISMATCH';
}

my %hashed_two;
foreach my $number (@list2) {
    if ( !defined $hashed_two{$number} ) {
        $hashed_two{$number} = 1;
    }
    else {
        $hashed_two{$number} += 1;
    }
}
while (@list1) {
    my $first_list = shift @list1;
    my $similarity2 =
      defined $hashed_two{$first_list} ? $hashed_two{$first_list} : 0;
    my $similarity = $first_list * $similarity2;
    $total += $similarity;
}
print "Total similarity: $total\n";
