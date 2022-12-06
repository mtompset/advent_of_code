#!/usr/bin/perl -Tw

use Modern::Perl;
use List::MoreUtils qw(uniq);
use Readonly;

our $VERSION = '1.0';
Readonly my $PACKET_END  => 3;     # 0-3 is 4 characters
Readonly my $MESSAGE_END => 13;    # 0-13 is 14 characters
Readonly my $UNSET       => -1;

my $data          = <>;
my $packet_start  = $UNSET;
my $message_start = $UNSET;
my @block;

my $end_point = ( length $data ) - $PACKET_END;
for my $count ( 0 .. $end_point ) {
    $#block = $UNSET;
    for my $offset ( 0 .. $PACKET_END ) {
        my $character = substr $data, $count + $offset, 1;
        push @block, $character;
    }
    my @check = uniq @block;
    if ( scalar @check == scalar @block ) {
        # $PACKET_END to get to the end of the string,
        # and +1 because the counting starts at 1, not 0.
        $packet_start = $count + $PACKET_END + 1;
        last;
    }
}

$end_point = ( length $data ) - $MESSAGE_END;
foreach my $count ( 0 .. $end_point ) {
    $#block = $UNSET;
    for my $offset ( 0 .. $MESSAGE_END ) {
        my $character = substr $data, $count + $offset, 1;
        push @block, $character;
    }
    my @check = uniq @block;
    if ( scalar @check == scalar @block ) {
        $message_start = $count + $MESSAGE_END + 1;
        $count         = length $data;
    }
}

print "Packet start: $packet_start\nMessage start: $message_start\n";
