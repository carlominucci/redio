#!/usr/bin/perl
use strict;
use warnings;
use Term::ReadKey;
 
my $filename = 'podcast.db';
my $tasto;
my @play;
my $titolo;
my $url;
my $key;
my $puntata;
my @lines;

START:
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

	while (my $row = <$fh>) {
		system("killall -9 mpg123");
 		chomp $row;
		my ($titolo, $url, $type) = split /\|/, $row;
  		print "$titolo\n";
		system("/home/pi/lcd.py \"" . $titolo . "\" " . "\"            --->\"");
		ReadMode 4;
        	while (not defined ($tasto = ReadKey(-1))) {
                	# No key yet
        	}
        	if($tasto eq "w"){
				if($type eq "p"){
				system("/home/pi/lcd.py " . "\"$titolo\"". " " . "\"sto caricando...\"");
				system("/home/pi/podcast.sh " . $url);
				open(DATA,"</tmp/podcast.now") or die "Can't open data";
				@lines = <DATA>;
				close(DATA);
				print @lines;
				$puntata = system("cat /tmp/podcast.now | tail -c 21");
				system("/home/pi/lcd.py " . "\">$titolo\"" . " " . substr($lines[0], -21));
        			print $titolo;
        			print $url;
				print "\n";
			}elsif($type eq "s"){
				system("/home/pi/lcd.py " . "\"$titolo\"". " " . "\"sto caricando...\"");
				system("mpg123 " . $url . " &");
				system("/home/pi/lcd.py " . "\"$titolo\"" . " " . "...streaming...");
			}
			while (not defined ($key = ReadKey(-1))) {
			}
			if($key eq "q"){
				system("killall -9 mpg123");
			}
        	}
		if($tasto eq "x"){
			ReadMode 0;
			exit;
		}
		ReadMode 0;
	}
goto START;
