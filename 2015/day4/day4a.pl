#!/usr/bin/perl -Tw

use Modern::Perl;
use Digest::MD5 qw(md5_hex);
use Const::Fast;

our $VERSION = '1.0';

const my $MINIMUM_INITIAL_ZEROS => 5;

my $prefix = <>;
chomp $prefix;
my $integer_counter = 1;
my $flag = 1;
while ($flag) {
    my $md5_hash_value = get_md5_hash($prefix, $integer_counter);
    if (count_initial_zeros($md5_hash_value) >= $MINIMUM_INITIAL_ZEROS) {
        --$integer_counter;
        $flag = 0;
    }
    ++$integer_counter;
}

print $prefix, "\n", $integer_counter, "\n", count_initial_zeros(get_md5_hash($prefix, $integer_counter)), "\n";

sub get_md5_hash {
    my ($input, $number) = @_;

    my $string = sprintf "%s%d", $input, $number;
    return md5_hex($string);
}

sub count_initial_zeros {
    my ($md5_hash_value) = @_;

    my $zero_count = 0;
    if ($md5_hash_value =~ /(^0+)/mxls) {
        my $initial_zeros = $1;
        $zero_count = length $initial_zeros;
    }
    return $zero_count;
}
