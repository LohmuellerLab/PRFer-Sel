#!perl

open OUT, ">pos_div_s-3epoch";
$Ne=2000;
$samplesize=100;
$theta=22033.64;
$tdiv=7.1578;
$tau=0.182138;
$tau_b=$tdiv - $tau;
$omega=4.413742;
$omega_b=0.427287;
$Ncur=16539.26;

print OUT "log10s\tdiv\n";

for (my $logS=-5; $logS <= -2; $logS += 0.001) {
	$s = 10 ** $logS;
	$gamma = 2 * $Ncur * $s;
	open OUT1, ">setting_positive-human";
	print OUT1 "fixed = 1\n";
	print OUT1 "poisson = 0\n";
	print OUT1 "samplesize = $samplesize\n";
	print OUT1 "Ne = $Ne\n";
	print OUT1 "THETA= $theta\n";
	print OUT1 "tdiv= $tdiv\n";
	print OUT1 "num_epochs = 3\n";
	print OUT1 "TAU = $tdiv -1 -1\n";
	print OUT1 "OMEGA = $omega -1 -1\n";
	print OUT1 "TAU_B = $tau_b -1 -1\n";
	print OUT1 "OMEGA_B = $omega_b -1 -1\n";
	print OUT1 "distrib = 1\n";
	print OUT1 "P $gamma -1 -1\n";
	print OUT1 "read_in_snps = 0\n";
	print OUT1 "run_type = 3\n";
	print OUT1 "input_grids = 0\n";
	print OUT1 "output_grids = 0\n";
	print OUT1 "num_iters = 0\n";
	close OUT1;
	
	system("./exec_fname setting_positive-human out_positive_s-human");
	
	open IN, "out_positive_s-human" or die "cannot open prfreq outfile";
	my $line1 = <IN>;
	my $line2 = <IN>;
	if ($line2 =~ 'expected poly:div'){
		($tmp1, $tmp2, $div)=split(':',$line2);
		$div =~ s/^\s//;
	}
	else {print "invalid prfreq outfile";}
	
	print OUT "$logS\t$div";
}
close OUT;

