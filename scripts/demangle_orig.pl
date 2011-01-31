#! /usr/bin/perl

use strict;
use subs;

# State:
#   0 - other
#   1 - after msgctxt
my $state = 0;
my $msgid_conv;
my $plural;

my $in_header = 1;

while (my $line = <>) {
    if ($in_header) {
	if ($line =~ /^msgctxt /) {
		$in_header = 0;
	} else {
		print $line;
		next;
	}
    }

    if ($state == 0) {
	if ($line =~ /^msgctxt "(.*)"/) {
		$state = 1;
		my $ctx = $1;
		if ($ctx =~ /^(.*)\|(.*)$/) {
			print "msgid \"$1\"\n";
			print "msgid_plural \"$1\"\n";
			$plural = 1;
		} else {
			print "msgid \"$ctx\"\n";
			$plural = 0;
		}
	}
    } else {
	if ($line =~ /^msgid/) {
		if ($plural) {
			$line =~ s/^msgid /msgstr[0] /;
			$line =~ s/^msgid_plural /msgstr[1] /;
		} else {
			$line =~ s/^msgid /msgstr /;
		}
		print $line;
	} elsif ($line =~ /^msgstr/) {
		$state = 0;
	} else {
		print $line
	}
    }
}
