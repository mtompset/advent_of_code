#!/usr/bin/perl -Tw

use Modern::Perl;
use Readonly;

our $VERSION = '1.0';
Readonly my $RANK_ONE => 1;

my $elves;
my $number_of_elves = 1;
my $current_energy  = 0;

my $data;
while ( $data = <> ) {
    $data =~ s/^\s+|\s+$//xslmg;
    if ( length $data == 0 ) {
        $number_of_elves++;
    }
    else {
        if ( exists $elves->{$number_of_elves} ) {
            $current_energy = $elves->{$number_of_elves}->{'energy'};
        }
        else {
            $current_energy = 0;
        }
        $elves->{$number_of_elves} = {
            'position' => $number_of_elves,
            'energy'   => $current_energy + int $data
        };
    }
}
print sprintf "%d\n", determine_energy_for_rank( $elves, $RANK_ONE );

sub determine_energy_for_rank {
    my ( $elf_data, $rank ) = @_;

    my @energies;
    my @sorted_energies;

    foreach my $elf ( keys %{$elf_data} ) {
        push @energies, $elf_data->{$elf}->{'energy'};
    }
    @sorted_energies = reverse sort { $a <=> $b } @energies;
    return $sorted_energies[ $rank - 1 ];
}
