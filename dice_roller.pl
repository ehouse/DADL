#!/usr/bin/perl
use warnings;
use strict;

my %stats;

# Read, Eval, loop
while () {
	# Variables
	my @array;
	my $total = 0;

	# Read user input
	print(">>");
	my $input = <>;
	chomp($input);

	# Eval section

	# Quit Program
	last if ($input eq 'quit') || ($input eq 'q') || ($input eq 'exit');

	# Dice Roller
	if($input =~ m/(\d+)?(d)(\d+)/){
		# Replace All Dice rolls
		$input =~ s/(\d+)?(d)(\d+)/dice($1,$3)/geis;
		@array = ($input =~ m/(\d+|\+)/g);
		foreach my $counter (0..$#array){
			if($array[$counter] =~ m/\+/g){
				$total += $array[$counter - 1];
				$total += $array[$counter + 1];
			}
			if($array[$counter] =~ m/\-/g){
				$total -= $array[$counter - 1];
				$total -= $array[$counter + 1];
			}
		}
		printf("(%d) %s\n",$total,$input);
	}

	# Stat Counter
	if($input =~ m/(\w+)\s?=\s?(\w+)/){
		$stats{$1}=$2;
	}

	# Stat Printer
	if($input =~ m/^print\s(\w+)/){
		if(exists($stats{$1})){
			print("$1 = $stats{$1}\n");
		}else{
			print("Stat does not exist\n");
		}
	}

	# Clear Screen
	if($input eq 'clear'){
		system('clear');
	}
}

sub dice{
	my ($num_dice, $sides) = @_;
	$num_dice ||= 1;
	my $roll = 0;

	for(my $x=0; $x < $num_dice; $x++){
		$roll += int(rand($sides))+1;
	}
	return $roll;
}
