#!/usr/bin/perl
use warnings;
use strict;

# variables
my $input; # store of user input

# Read, Eval, loop
while () {
	# Read
	print(">>");
	$input = <>;
	chomp($input);

	# Eval
	last if ($input eq 'quit') || ($input eq 'q') || ($input eq 'exit');
	# Dice Roller
	$input =~ s/(\d+)?(d)(\d+)/dice($1,$3)/geis;

	# print 
	if($input){
		print("$input\n");
	}
}
sub dice{
	# $_[0] = num of dice
	# $_[1] = sides of dice
	my $num_dice;
	if(!defined($_[0])){
		$num_dice = 1;
	}else{
		$num_dice = $_[0];
	}
	my $sides = $_[1];
	my $roll = 0;

	for(my $x=0; $x < $num_dice; $x++){
		$roll += int(rand($sides))+1;
	}
	return $roll;
}
