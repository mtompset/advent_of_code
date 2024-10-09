#!/usr/bin/perl -Tw

use Modern::Perl;
use JSON;
use Data::Dumper;
use Scalar::Util qw/reftype/;
use Scalar::Util qw/looks_like_number/;

our $VERSION = '1.0';

my $data   = <>;
my $decoded_data = decode_json($data);

if (reftype $decoded_data eq reftype {}) {
    print count_hash($decoded_data), "\n";
} else {
    print count_array($decoded_data), "\n";
}

sub count_array
{
    my ($arrayref) = @_;

    my @array = @{$arrayref};
    my $subtotal = 0;
    my $total = 0;
    foreach my $entry (@array) {
        if (looks_like_number($entry)) {
            $subtotal = $entry;
        } elsif (! defined reftype $entry) {
            $subtotal = 0;
        } elsif (reftype $entry eq reftype {}) {
            $subtotal = count_hash($entry);
        } elsif (reftype $entry eq reftype []) {
            $subtotal = count_array($entry);
        } else {
            $subtotal = 0;
        }
        $total += $subtotal;
    }
    return $total;
}

sub count_hash
{
    my ($hashref) = @_;

    my %hash = %{$hashref};
    foreach my $entry (keys %hash) {
        my $value = $hash{$entry};
        if (! defined reftype $value && $value eq 'red') {
            return 0;
        }
    }
    my $subtotal = 0;
    my $total = 0;
    foreach my $entry (keys %hash) {
        my $value = $hash{$entry};
        if (looks_like_number($value)) {
            $subtotal = $value;
        } elsif (! defined reftype $value) {
            $subtotal = 0;
        } elsif (reftype $hash{$entry} eq reftype {}) {
            $subtotal = count_hash(\%{$hash{$entry}});
        } elsif (reftype $hash{$entry} eq reftype []) {
            $subtotal = count_array(\@{$hash{$entry}});
        } else {
            $subtotal = 0;
        }
        $total += $subtotal;
    }
    return $total;
}
