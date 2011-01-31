#! /usr/bin/perl

use strict;
use subs;

# State:
#   0 - other
#   1 - after msgctxt
my $state = 0;
my $msgid_conv;

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
		} else {
			print "msgid \"$ctx\"\n";
		}
	} else {
		print $line
	}
    } else {
	if ($line =~ /^msgstr/) {
		$state = 0;
		print $line;
	}	
    }
}
