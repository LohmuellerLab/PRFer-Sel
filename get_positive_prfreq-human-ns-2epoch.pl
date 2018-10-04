#!perl

open OUT, ">pos_div-human-ns-2epoch";
$Ne=2000;
$samplesize=100;
$theta=22033.64;
$tdiv=6.8647;
$tau=0.182138;
$omega=0.427287;
print OUT "gamma\tdiv\n";

foreach $i (0..3*1000) {

	$gamma = 10 ** ($i/1000);
	open OUT1, ">setting_positive-human-ns-2epoch";
	print OUT1 "fixed = 1\n";
	print OUT1 "poisson = 0\n";
	print OUT1 "samplesize = $samplesize\n";
	print OUT1 "Ne = $Ne\n";
	print OUT1 "THETA= $theta\n";
	print OUT1 "tdiv= $tdiv\n";
	print OUT1 "num_epochs = 2\n";
	print OUT1 "TAU = $tau -1 -1\n";
	print OUT1 "OMEGA = $omega -1 -1\n";
	print OUT1 "distrib = 1\n";
	print OUT1 "P $gamma -1 -1\n";
	print OUT1 "read_in_snps = 0\n";
	print OUT1 "run_type = 3\n";
	print OUT1 "input_grids = 0\n";
	print OUT1 "output_grids = 0\n";
	print OUT1 "num_iters = 0\n";
	close OUT1;
	
	system("./exec_fname setting_positive-human-ns-2epoch out_positive-human-ns-2epoch");
	
	open IN, "out_positive-human-ns-2epoch" or die "cannot open prfreq outfile";
	my $line1 = <IN>;
	my $line2 = <IN>;
	if ($line2 =~ 'expected poly:div'){
		($tmp1, $tmp2, $div)=split(':',$line2);
		$div =~ s/^\s//;
	}
	else {print "invalid prfreq outfile";}
	
	print OUT "$gamma\t$div";
}
close OUT;

