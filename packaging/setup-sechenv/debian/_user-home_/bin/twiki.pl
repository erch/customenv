#!/usr/bin/perl -w
# -*-cperl-*-

use strict;
use warnings;

use Cwd;
use Pod::Usage;
use Log::Log4perl;
use Getopt::Long ( ":config", "no_ignore_case", "gnu_getopt",
	"bundling_override" );
use Time::HiRes;
use Data::Dumper;
use POSIX qw(strftime);
use WWW::TWikiClient;
use File::Spec;
use IO::Prompt;
use HTML::Entities;
use HTTP::Cookies;
use URI::file;
use URI::Escape;
use HTML::Entities;


$| = 1;

# What's my name?
my $myName = File::Basename::basename($0);
my $myDir  = Cwd::abs_path( File::Basename::dirname($0) );

Log::Log4perl::init( File::Spec->catdir( $myDir, 'log4perl.conf' ) );
my $logger = Log::Log4perl->get_logger('twiki.main');

# Options given to the program
my $optctl = {};

# Options description
my @optDesc = (
	"help|?",  "read|r",    "save|s", "attach|a",
	"dir|d=s", "topic|t=s", "user|u=s"
);

my $tClient = new WWW::TWikiClient;

my @filesOrTopics = ();

# -------------------------- printUsage ---------------------------------
#  print usage
# ------------------------------------------------------------------
sub printUsage {
	my $msg     = shift;
	my $exitval = shift;
	my $verbose = shift;
	pod2usage(
		{
			-msg     => $msg,
			-exitval => $exitval,
			-verbose => $verbose,
			-output  => \*STDERR
		}
	);
}

# -------------------------- parseArg ---------------------------------
#  parse a non option argument
# ------------------------------------------------------------------
sub parseArg {
	my ($arg) = @_;
	foreach my $f (@_) {
		$logger->debug( "option file : $f , size of filesOrTopics "
			  . scalar(@filesOrTopics) );

		# check file rights per command
		if ( defined $optctl->{"read"} ) {

			# for read we accept only one file or one directory
			push( @filesOrTopics, $f );
		}
		if ( defined $optctl->{"save"} || defined $optctl->{"attach"} ) {

			# must be a file
			if ( !-f $f ) {
				printUsage( "option --file must be a file: " . $f, 2, 2 );
			}

			# file must exist and be readable
			printUsage( "file " . $f . "  must be readable", 2, 2 )
			  unless -r $f;

			push( @filesOrTopics, $f );
		}
	}
}

# -------------------------- checkArgs ---------------------------------
#  check command line arguments, set default values, exit on errors
# ------------------------------------------------------------------
sub checkArgs {
	my $optctl = shift;
	my $cmd    = "";
	printUsage( "", 0, 2 ) if defined( $optctl->{"help"} );

	printUsage( "missing value for mandatory option --user", 2, 2 )
	  unless defined $optctl->{"user"};

	printUsage( "missing one of mandatory option --read, --write or --attach ",
		2, 2 )
	  unless defined $optctl->{"read"}
		  || defined $optctl->{"save"}
		  || defined $optctl->{"attach"};

	printUsage(
		"only one command --read, --write or --attach can be specified at once",
		2,
		2
	  )
	  unless ( defined $optctl->{"read"}
		&& !defined $optctl->{"save"}
		&& !defined $optctl->{"attach"} )
	  || (!defined $optctl->{"read"}
		&& defined $optctl->{"save"}
		&& !defined $optctl->{"attach"} )
	  || ( !defined $optctl->{"read"}
		&& !defined $optctl->{"save"}
		&& defined $optctl->{"attach"} );

	printUsage( "missing mandatory option --topic", 2, 2 )
	  unless defined( $optctl->{"topic"} ) || !defined( $optctl->{"attach"} );

	printUsage( "option --dir is valid only with operation read ", 2, 2 )
	  if defined( $optctl->{"dir"} ) && !defined( $optctl->{"read"} );

	printUsage( "argument for option --dir must be a writable directory ",
		2, 2 )
	  if defined( $optctl->{"dir"} )
		  && !-d $optctl->{"dir"}
		  && !-w $optctl->{"dir"};

	$cmd =
	    defined( $optctl->{"read"} ) ? "read"
	  : defined( $optctl->{"save"} ) ? "save"
	  :                                "attach";
	$logger->info(
		"command: $cmd , filesOrTopics : " . join( " , ", @filesOrTopics ) );
}

# -------------------------- getTime ---------------------------------
#  format a time stampl
# ------------------------------------------------------------------
sub getTime {
	return strftime "%Y-%b-%a-%T", localtime;
}

# -------------------------- initTwiki ---------------------------------
#  init the twiki
# ------------------------------------------------------------------
sub initTwiki($) {
	my ($cookiejar) = @_;
	# authentication

	my $password = prompt( 'Twiki password:', -e => '*' );

	$tClient->auth_user( $optctl->{"user"} );
	$tClient->auth_passwd($password);
	#$tClient->add_header('Accept-Charset' => "utf-8");
#	$tClient->add_header('Content-Type' => 'application/text; charset=UTF-8');
	# handling locks
	$tClient->override_locks(0);    # default 0,
	                                # set to 1 if locked topics
	                                # should be "edited anyway"
	                                # base config
	$tClient->bin_url('http://twiki.bestofmedia.com/bin/');
	$tClient->current_default_web('Product');   # used if not contained in topic
	

	$tClient->cookie_jar($cookiejar);

	$logger->info("init done");
}

# -------------------------- doRead ---------------------------------
#  read a topic in the twiki
# ------------------------------------------------------------------
sub doRead {

	my $dir = defined( $optctl->{"dir"} ) ? $optctl->{"dir"} : ".";
	foreach my $tpc (@filesOrTopics) {
		my $f = File::Spec->catfile( $dir, $tpc . ".twiki" );
		$logger->debug( "reading topic " . $tpc . " to file " . $f );
		$tClient->current_topic($tpc);

		# read raw text
		my $topic_content = "";
		$topic_content = $tClient->read_topic() or die "couldn't read topic";
		decode_entities($topic_content);

		open( FILE, ">" . $f )
		  or die "couldn't open file " . $f . " for writing";
		print( FILE $topic_content );
		close(FILE);
		$logger->info( "read done in file : " 
			  . $f
			  . " , httpstatus = "
			  . $tClient->status() );
	}
}

# -------------------------- doSave ---------------------------------
#  save a topic in the twiki
# ------------------------------------------------------------------
sub doSave {
	my $holdTerminator = $/;
	undef $/;
	my $curTopic;
	foreach my $f (@filesOrTopics) {
		($curTopic) = $f =~ /^(.*)\.twiki$/;
		printUsage( "file " . $f . "  doesn't have a .twiki extension", 2, 2 )
		  unless $curTopic;
		$curTopic = File::Basename::basename($curTopic);
		$tClient->current_topic($curTopic);
		$logger->debug( "Going to save file $f to topic " . $curTopic );
		open( FILE, "<" . $f )
		  or die "couldn't open file " . $f . " for reading";

		my $content = encode_entities(<FILE>,'\x80\xC0-\xFF');
		#$logger->debug("content to save : \n$content");
		$tClient->save_topic($content) or die "couldn't save topic";
		close FILE;
	}
	$/ = $holdTerminator;
}

# -------------------------- doAttach ---------------------------------
#  attach file to a topic in the twiki
# ------------------------------------------------------------------
sub doAttach {
	$tClient->current_topic( $optctl->{"topic"} );
	foreach my $f (@filesOrTopics) {

		# attach a file
		$f !~ /^\/.*$/ and $f = File::Spec->catfile( ".", $f );
		$logger->debug(
			"Going to attach file $f to topic " . $optctl->{"topic"} );
		$tClient->attach_to_topic(File::Spec->canonpath($f), "send by twiki.pl", 0, 0);
		$logger->info( "attach done in topic : "
			  . $optctl->{"topic"}
			  . " , httpstatus = "
			  . $tClient->status() );
	}
}

# -------------------------- MAIN ------------------------------
# Beginning of the script.
# --------------------------------------------------------------
$logger->info( "Starting at " . getTime() );

GetOptions( $optctl, @optDesc, "<>" => \&parseArg ) or printUsage( "", 2, 2 );
checkArgs($optctl);

my $cookie_jar = HTTP::Cookies->new(
				    file     => "$ENV{'HOME'}/.twikiClient_cookies.dat",
				    autosave => 1,
				    ignore_discard => 1
				   );
initTwiki( $cookie_jar);
if ( defined( $optctl->{"read"} ) ) {
	doRead();
}
elsif ( defined( $optctl->{"save"} ) ) {
	doSave();
}
elsif ( defined( $optctl->{"attach"} ) ) {
	doAttach();
}
else {
	die "didn't get what to do";
}
 $cookie_jar->save();
$logger->info( "Ending at " . getTime() );

__END__

=head1 NAME

twiki.pl - fetch and send twiki topics to twiki / disk

=head1 SYNOPSIS

	twiki.pl [--help] --save --user <user> <file> [<file>]*
	twiki.pl [--help] --attach --user <user> --topic <topic> <file> [<file>]*
	twiki.pl [--help] --read --user <user> [--dir <dir>] <topic> [<topic>]*

Options can be reduced to a simple letter prefixed by only one dash (-r for instance)

=head1 OPTIONS

=over 8

=item B<user>

user name.

=item B<topic>

for read operation that's the topic to read and write to a file named <topic>.twiki
for attach operation that's the topic to which files will be attached.

=item B<read | save | attach>

The operation requested.

=item B<file>

The path where to find the file to save or attach
For read the file name must be in the form <topic>.twiki where topic is the name of the topic where to write the file.

=item B<dir>

The path of a directory where to write the content of the topic fetched from the twiki.

=back

=head1 DESCRIPTION

B<This program> will read, save a topic in a twiki or send attachment files to it.


=head1 DEPENDENCIES

This program uses module WWW::TWikiClient , on debian do:

=over 8

	sudo apt-get install libwww-mechanize-twiki-perl
	sudo cpan -i WWW::TWikiClient
	sudo cpan -i HTTP::Cookies::Find

=back

=cut
