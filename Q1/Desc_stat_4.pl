#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin); #for including libraries-points to the directory holding this file
use lib "$Bin/lib";  #required libraries can be added to lib dir

use Statistics::Descriptive;  #module to find descriptive statistics
use LWP::Simple;	#module to use getstore - download file

#@ARGV == 2 or die "Usage: $0 <url> <output_dir>\n";

my $url = "http://thin.med.ucalgary.ca/data/analyst-data.csv";
my $file = "analyst-data-sample.csv";
print("downloading file from $url. This may take 2-3 minutes....\n");
my $response = getstore($url,$file);   #download file
if(is_error($response))                 #check if download success/failure
{
        die "getstore of $url is failed with $response\n";
}
else
{
	print("download Success.\n");
}

open(IN,"<$file") or die "Can not open $file for reading :$!\n"; #open file for reading

my %data; ## This will be a hash of lists, holding the data
my @names; ## This will hold the names of the columns
my $lineCnt=0; #no of records

###reading the .csv file
while (<IN>) 
{
    chomp;
    my @list=split(/\,/); ## Collect the elements of this line
    for (my $i=0; $i<=$#list; $i++) 
     {
     	#If this is the 1st line, collect the names(col)
     	if ($.==1) 
		{
                	$names[$i]=$list[$i];
                	$names[$i] =~ s/"//g;   #to delete quotes from the names
			
               	}
     	# If it is not the 1st line, collect the data
         else {
                        push @{$data{$names[$i]}}, $list[$i];
              }
     }
$lineCnt=$.-1;
}

#print the descriptive statistics of v1,v2 and v3
print "No of records=$lineCnt\n";
print "No of Columns=$#names\n\n";
my %stat;
my @valueCols=("v1","v2","v3");
print "col\tmean\tmode\tmedian\tSkewness(0,+,-)\tVariance\tStdDev\trange\tpercentile(25)\n";
print "***********************************************************************************\n";
foreach(@valueCols)
{
	   $stat{$_} = Statistics::Descriptive::Full->new();
           $stat{$_}->add_data(@{$data{$_}});
           my $mean = $stat{$_}->mean();
	   my $mode = $stat{$_}->mode();
	 	  if(!defined($mode)) {$mode="Null";}  #all items are repeated once
	   my $median = $stat{$_}->median();
	   my $skew = $stat{$_}->skewness();
	   my $var = $stat{$_}->variance();
           my $sd = $stat{$_}->standard_deviation();
	   my $range = $stat{$_}->sample_range();
	   my $perc = $stat{$_}->percentile(25);
           print "$_\t$mean\t$mode\t$median\t$skew\t$var\t$sd\t$range\t$perc\n";        
}


