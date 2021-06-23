#!/usr/bin/env perl

use warnings;
use strict;

die "Please pass the file name to be processed as parameter" if scalar @ARGV < 1;
die "One file at the time" if scalar @ARGV > 1;
die "file not found" if !(-e $ARGV[0]);

my $filename = $ARGV[0];

open( my $fh, '<', $filename) or die "Could not open file " . $filename . "$!\n";

my @structure;

my $parent;
my $parent_value;

while ( my $line = <$fh> ){
    chomp($line);
    
    if ($line =~ m/(parent\d+)=(\d+)/gi){
        $parent = $1;
        $parent_value = $2;
    }

    if ($line =~ m/-(child\d+)=(\d+)/gi){
        die "parent not found" unless $parent;
        push @structure, $parent .' - '. $1 . '=' . $parent_value . '~' . $2; #For esthetic purpose I will create the structure and then print it
    }

}

map { print $_."\n" } @structure;