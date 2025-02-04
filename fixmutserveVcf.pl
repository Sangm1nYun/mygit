#!/usr/bin/env perl
 
use strict;
use warnings;
use Getopt::Long;

MAIN:
{
	my %opt;
	my $result = GetOptions(
 	               "file=s" 	=> \$opt{file},
 	       );
	die "ERROR: $! " if (!$result);
	die "ERROR: $! " if (!defined($opt{file}));
	
	my $chrM="";
	open(IN,$opt{file}) or die "ERROR:$!";
        while(<IN>)
        {
                if(/>/) {}
                else
                {
                        chomp;
                        $chrM.=$_;
                }
        }
	close(IN);
	
	###################################################

	my @P;
	while(<>)
	{

		if(/^$/)
		{
			next;
		}
		elsif(/^#/)
		{
			print;
			next;
		}

		my @F=split;

		if($F[1]==3105 and $F[4] eq "*")    { next }
		elsif($F[1]==3106 and $F[4] eq "*") { next }
		elsif($F[1]==3107)                  { next }
		elsif($F[1]==3108 and $F[4] eq "*") { next }
		elsif(@P and $P[4] eq "*")
		{
			if($F[4] eq "*")
	               	{
        	               	$P[3].=$F[3]
               		}
			else
			{
				$P[1]--;
				$P[4]=substr($chrM,$P[1]-1,1);
				$P[3]="$P[4]$P[3]";
				print join "\t",@P;print "\n";
				print;
				@P=();
			}
		}
		elsif($F[4] eq "*")
		{
			@P=@F
		}
		else
		{
			print;
		}
	}

	if(@P)
	{
		$P[1]--;
		$P[4]=substr($chrM,$P[1]-1,1);
		$P[3]="$P[4]$P[3]";

		print join "\t",@P; 
		print "\n"
	}
}

