#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin); #add libraries - points to the dir holding this file
use lib "$Bin/lib";	#libs can ne added to lib dir
use Statistics::Descriptive;  #module to find mean and sd

#read the .csv file
my %data; ## This will be a hash of lists, holding the data
my @names; ## This will hold the names of the columns
while (<>) 
{
    chomp;
    my @list=split(/\,/); ## Collect the elements of this line
    for (my $i=0; $i<=$#list; $i++) 
     {
     	#If this is the 1st line, collect the names
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
}

my @uniqueTime = do { my %seen; grep { !$seen{$_}++ } @{$data{time}} }; ##find the no of different distribution using time field

my %dist=();

#create separate bins for different distribution
for (my $i=0; $i<=$#uniqueTime; $i++)
{
	for (my $j=0; $j<=$#{$data{time}}; $j++)
	{
		if(@{$data{time}}[$j] == $uniqueTime[$i])
		{
			push(@{$dist{$uniqueTime[$i]}},@{$data{v1}}[$j]);		
		}
	}
	
}

my %stat;
#find the mean and sd
foreach(@uniqueTime)
{
	   $stat{$_} = Statistics::Descriptive::Full->new();
           $stat{$_}->add_data(@{$dist{$_}});
           my $mean = $stat{$_}->mean();
           my $sd = $stat{$_}->standard_deviation();
           print "mean and sd of time $_ distribution are: $mean\t$sd\n";        
}

=begin comment
foreach (@uniqueTime)
{
           local $"="\t"; ## print tab separated lists
           print "$_\t@{$dist{$_}}\n";
}
=cut

