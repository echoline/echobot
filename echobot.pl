#!/usr/bin/perl -w
# irc.pl
# A simple IRC robot.
# Usage: perl irc.pl

use strict;

# We will use a raw socket to connect to the IRC server.
use IO::Socket;

use lib 'lib/';
use RiveScript;

# The server to connect to and our details.
my $server = "echoline.org";
my $nick = "echobot";
my $login = "echobot";

# The channel which the bot will join.
my $channel = "#neoturbine";

for (my $argnum = 0; $argnum <= $#ARGV; $argnum++) {
	if ($ARGV[$argnum] eq '-j') {
		$channel = $ARGV[++$argnum];
	} elsif ($ARGV[$argnum] eq '-n') {
		$nick = $ARGV[++$argnum];
		$login = $ARGV[$argnum];
	} elsif ($ARGV[$argnum] eq '-s') {
		$server = $ARGV[$argnum];
	} else {
		die ("usage");
	}
}

# Connect to the IRC server.
my $sock = new IO::Socket::INET(PeerAddr => $server,
				PeerPort => 6667,
				Proto => 'tcp') or
					die "Can't connect\n";

# Log on to the server.
print $sock "NICK $nick\r\n";
print $sock "USER $login 8 * :echobot3\r\n";

# Read lines from the server until it tells us we have connected.
while (my $input = <$sock>) {
	# Check the numerical responses from the server.
	if ($input =~ /004/) {
		# We are now logged in.
		last;
	}
	elsif ($input =~ /433/) {
		print "Nickname is already in use.";
		$nick .= '_';
		print $sock "NICK $nick\r\n";
	}
}

our $rs = new RiveScript;
$rs->loadDirectory ("replies/");
$rs->sortReplies;

# Join the channel.
print $sock "JOIN $channel\r\n";

# Keep reading lines from the server.
while (my $input = <$sock>) {
	chop $input;
	if ($input =~ /^PING(.*)$/i) {
		# We must respond to PINGs to avoid being disconnected.
		print $sock "PONG $1\r\n";
	}
	elsif ($input =~ /PRIVMSG/) { 
		my $chunk = substr($input, 1);
		my $from = substr($chunk, 0, index($chunk, "!"));
		my $msg = substr($chunk, index($chunk, ":")+1);
		my @parts = split(/ /, substr($chunk, 0, index($chunk, ":")));

		if ($parts[1] ne 'PRIVMSG') {
			next;
		}

		print $from . " says " . $msg . "\n";

		if ($parts[2] =~ $channel) {
			$msg =~ s/^$nick\W*//;
			reply($from, $channel, $msg);
		}
		elsif ($parts[2] =~ $nick) {
			reply($from, $from, $msg);
		}
	}
	else {
		# Print the raw line received by the bot.
		print "$input\n";
	}
}

sub reply {
	my ($from, $to, $msg) = @_;

	my $reply = $rs->reply($from, $msg);

	if ($reply =~ /^ERR:/) {
		print "$reply\n";
	} else {
		print $sock "PRIVMSG $to :$reply\r\n";
		print "I say $reply\n";
	}
}
