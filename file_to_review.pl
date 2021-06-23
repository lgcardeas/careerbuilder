#!/usr/bin/env perl

#Task 1 
#Please code review a little Perl script below and update where you see errors.  

use warnings; 
use strict; 
use Bean::DB qw(get_dbi);

my $csv_dir = '/tmp'; 
my $csv_filename = 'gradleaders_feed_list.csv'; 
my $csv_path = $csv_dir . '/' . $csv_filename;

open(my $csv, '>', $csv_path) or die "Could not open file " . $csv_path . "$!\n";

# Database Handler 
my $dbh = get_dbi('reports');

print "\nDEBUG - Starting Report.\n";

my $boards_query = $dbh->prepare(" SELECT id, name, nice_name, url FROM board WHERE url like '%mbafocus%' OR url like 'myinterfase' "); 
$boards_query->execute(); 

print $csv "Board ID,Name,Nice Name,URL\n"; 
while (my %board = $boards_query->fetchhash()) {
    print $csv $board{'id'}.",".$board{'nice_name'}.",".$board{'name'}.",".$board{'url'}."\n";  
};
close $csv;

print "DEBUG - Finished Report.\n"; 