#!/usr/bin/perl

$root = "";  # assume that this is run from within the Turtle-diff directory
$dirA = "../Turtle/";
$dirB = "../Turtle-simple-context/";
$dirC = "./";

@filesA=($root.$dirA);
@filepaths=();

open (LOG, ">$dirC"."allDiffs.txt");

foreach $element (@filesA) {

	print "File: $element\n";

	$diffelement=$element;
	$diffelement=~ s/^$root$dirA/$root$dirC/;

	print "File: $diffelement\n";


	opendir my $dir, $element or die "Cannot open directory: $!";
	my @contents = readdir $dir;
	closedir $dir;

	my @subdirs=();


	foreach $file (@contents) {
		unless ($file=~ /^\./) {

			if (-d $element.$file) {
				push @filesA, $element.$file; # removed trailing forward slash
				
				mkdir $diffelement."/".$file;
	
			} else {
				push @filepaths, $element."/".$file;
			}
	
		}
	}


}


foreach $pathA (@filepaths) {
	$pathB = $pathA;
	$pathC = $pathA;
	$pathB=~ s/^$root$dirA/$root$dirB/;
	$pathC=~ s/^$root$dirA/$root$dirC/;
	$pathC=~ s/\/\//\//;
	$pathC=~ s/\.ttl$/.diff/;

	print LOG "\n$pathC\n\n";
	
	if ($pathA=~ /\.ttl$/) {
	
		$diff = `/usr/bin/diff --ignore-space-change -U 0 $pathA $pathB`;
	
		open (OUT, ">$pathC");
		print OUT $diff;
		print LOG "$diff\n\n";
		close (OUT);


	}

}

close (LOG);