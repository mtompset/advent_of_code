#!/usr/bin/perl -Tw

use Modern::Perl;
use Array::Utils qw(:all);
use List::MoreUtils qw(uniq);
use Data::Dumper;
use Carp qw(croak);
use Readonly;

our $VERSION = '1.0';
Readonly my $WIDTH_OF_COLUMN => 4;

my $data;
my @input;
while ( $data = <> ) {
    push @input, $data;
}

my @board;
my @moves;

foreach my $line (@input) {
    $line =~ s/\r/\n/xslmg;
    $line =~ s/\n//xslmg;
    if ( $line =~ /^move/xslmg ) {
        push @moves, $line;
    }
    else {
        push @board, $line;
    }
}

$#board = $#board - 2;

my $number_of_stacks = ( ( length $board[0] ) + 1 ) / $WIDTH_OF_COLUMN;

@board = reverse @board;

my @stacks;
for my $stack_number ( 1 .. $number_of_stacks ) {
    push @stacks, [];
}

foreach my $row (@board) {
    for my $stack_number ( 0 .. $number_of_stacks - 1 ) {
        my $position = 1 + ($stack_number) * $WIDTH_OF_COLUMN;
        my $box      = substr $row, $position, 1;
        if ( $box ne q{ } ) {
            push @{ $stacks[$stack_number] }, $box;
        }
    }
}

foreach my $instruction (@moves) {
    if ( $instruction =~ /move\s(\d\d*)\sfrom\s(\d\d*)\sto\s(\d\d*)/xslm ) {
        my $how_many          = $1;
        my $from_stack_number = $2 - 1;
        my $to_stack_number   = $3 - 1;
        my @boxes;
        for my $move_number ( 1 .. $how_many ) {
            push @boxes, pop @{ $stacks[$from_stack_number] };
        }
        for my $move_number ( 1 .. $how_many ) {
            push @{ $stacks[$to_stack_number] },
              $boxes[ $how_many - $move_number ];
        }
    }
}

my $result = q{};
foreach my $stack (@stacks) {
    my $top = pop @{$stack};
    $result .= $top;
}
print "$result\n";
