#!/usr/bin/perl -Tw

use Modern::Perl;
use Readonly;

our $VERSION = '1.0';
Readonly my $LAST_CHARACTER => -1;

my $total_score = 0;
my $data;
while ( $data = <> ) {
    $data =~ s/^\s+|\s+$//xslmg;
    if ( length $data > 0 ) {
        my $score = score_round($data);
        $total_score += $score;
    }
}
print "${total_score}\n";

sub score_round {
    my ($round_data) = @_;

    return calculate_score($round_data) + calculate_score_delta($round_data);
}

sub get_scoring_map {
    return {
        'draw' => 3,
        'win'  => 6,
        'loss' => 0
    };
}

sub calculate_move {
    my ($round_data) = @_;

    my $move     = substr $round_data, $LAST_CHARACTER, 1;
    my $move_map = {
        'X' => 'A',
        'Y' => 'B',
        'Z' => 'C'
    };
    return $move_map->{$move};
}

sub calculate_score {
    my ($round_data) = @_;

    my $my_move       = calculate_move($round_data);
    my $opponent_move = substr $round_data, 0, 1;

    my $scoring_map = get_scoring_map();
    my $score       = {
        'A A' => $scoring_map->{'draw'},
        'A B' => $scoring_map->{'win'},
        'A C' => $scoring_map->{'loss'},
        'B A' => $scoring_map->{'loss'},
        'B B' => $scoring_map->{'draw'},
        'B C' => $scoring_map->{'win'},
        'C A' => $scoring_map->{'win'},
        'C B' => $scoring_map->{'loss'},
        'C C' => $scoring_map->{'draw'}
    };
    my $key = sprintf '%s %s', $opponent_move, $my_move;
    return $score->{$key};
}

sub calculate_score_delta {
    my ($round_data) = @_;

    my $my_move = calculate_move($round_data);

    my $score_delta = {
        'A' => 1,
        'B' => 2,
        'C' => 3,
    };
    return $score_delta->{$my_move};
}
