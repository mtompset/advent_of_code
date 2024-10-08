#!/usr/bin/perl -w

use Modern::Perl;
use File::Basename;
use File::Path;
use List::MoreUtils qw(uniq);
use Data::Dumper;
use Carp qw(croak);
use Readonly;

our $VERSION = '1.0';

my @data = <>;

my $pwd = q{/};
my $file_structure = {};
rmtree('/tmp/aoc');
foreach my $row (@data) {
    chomp $row;
    if ( $row =~ /^\$\s(.*)/xslm ) {
        my $command = $1;
        print "\$ $command\n";
        if ( $command =~ /cd\s(.*)/xslm ) {
            my $directory_name = $1;
            if ( $directory_name eq q{..} ) {
                $pwd = sprintf "%s/", dirname($pwd);
                $pwd =~ s/^\/\/$/\//g;
            } elsif ( $directory_name eq q{/} ) {
                $pwd = q{/};
            } else {
                $pwd = sprintf "%s%s/", $pwd, $directory_name;
            }
            print "CURRENT DIRECTORY: $pwd\n";
            mkdir sprintf '/tmp/aoc/%s', $pwd;
        }
    } elsif ( $row =~ /^dir\s(.*)/xslm ) {
        my $directory_name = $1;
        print "dir $directory_name\n";
    } elsif ( $row =~ /^(\d\d*)\s(.*)/xslm ) {
        my $file_size = int($1);
        my $file_name = $2; 
        print sprintf "%d %s\n", $file_size, $file_name;
        open my $FH, '>', (sprintf '/tmp/aoc/%s/%s', $pwd, $file_name) || croak "can't make it!\n";
        print $FH "$file_size\n";
        close $FH;
    } else {
        print "WHAT?!\n";
    }
}
