#!/usr/bin/perl
use warnings;
use strict;

my %store;
my %runtime = ('cmd' => '>>');

# Read, Eval, loop
while () {
	# Variable Declaration
	my @array;  # store for information across program
	
	# Read user input
	print($runtime{cmd});
	my $input = <>;    # internal info string, doesn't look pretty like $output
	chomp($input);
	
	##### Eval section ######
	
	# Quit Program
	last if ($input eq 'quit') || ($input eq 'q');
	
	# Clear Screen
	if($input eq 'clear'){
		system('clear');
		next;
	}
	
	# Dice Roller
	if($input =~ m/(\d+)?(d)(\d+)/){
		# Replace All Dice rolls
		$input =~ s/(\d+)?d(\d+)/"$1d$2(".dice($1,$2).")"/ge;
		my $output = $input;
		$input =~ s/\d+d\d+\((\d+)\)/$1/g;
		print $output."\n";
	}
	
	# Arithmetic
	@array = $input =~ m/(\d+|\+|\-)/g;
	my $total = $array[0];
	foreach my $counter (1..$#array){
		if($array[$counter] =~ m/\+/g){
			$total += $array[$counter + 1];
		}
		if($array[$counter] =~ m/\-/g){
			$total -= $array[$counter + 1];
		}
	}
	if($total){
		printf("(%d) %s\n",$total,$input);
	}else{
	}
	
	# Stat Counter
	if($input =~ m/(\w+)\s+?=\s+?(\w+)/g){
		if($total){
			$store{$1}=$total;
		}
	}
	
	# Stat Printer
	if($input =~ m/^print\s(\w+)/){
		if(exists($store{$1})){
			print("$1 = $store{$1}\n");
		}else{
			print("Stat does not exist\n");
		}
	}
}

sub dice{
	my ($num_dice, $sides) = @_;
	if($num_dice == 0 || $sides == 0){
		return 0;
	}
	$num_dice ||= 1;
	my $roll = 0;

	for(my $x=0; $x < $num_dice; $x++){
		$roll += int(rand($sides))+1;
	}
	return $roll;
}

### End of File
