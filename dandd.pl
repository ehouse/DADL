#!/usr/bin/perl
use warnings;
use strict;


# Read, Eval, loop
while () {
	# Variables
	my @array;
	my $total = 0;
	# Read
	print(">>");
	my $input = <>;
	chomp($input);

	# Eval
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
	}

	# print 
	if($input){
		printf("(%d) %s\n",$total,$input);
	}
	if($input eq 'clear'){
		system('clear');
	}
}

sub dice{
	# $_[0] = num of dice
	# $_[1] = sides of dice

	my $sides = $_[1];
	my $roll = 0;
	my $num_dice;

	if(!defined($_[0])){
		$num_dice = 1;
	}else{
		$num_dice = $_[0];
	}

	for(my $x=0; $x < $num_dice; $x++){
		$roll += int(rand($sides))+1;
	}
	return $roll;
}
