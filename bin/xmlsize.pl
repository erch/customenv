#!/usr/bin/perl -w
# -*-cperl-*-

use strict;
use warnings;
use File::Basename;
use Date::Parse; 
 use XML::LibXML;
use Data::Dumper;
use Cwd;
use Pod::Usage;
use Log::Log4perl;
use Getopt::Long ( ":config", "no_ignore_case", "gnu_getopt",
		   "bundling_override" );
use Time::HiRes;
use Data::Dumper;
use POSIX qw(strftime);
use File::Spec;

$| = 1;

# What's my name?
my $myName = File::Basename::basename($0);
my $myDir  = Cwd::abs_path( File::Basename::dirname($0) );


my $log4PerlFile = File::Spec->catdir( $myDir, 'log4perl.conf' );
if (-r $log4PerlFile) {
    Log::Log4perl::init($log4PerlFile);
}
else {
    my $logConf = q/ 
    log4perl.rootLogger=DEBUG, LOGFILE
    log4perl.appender.LOGFILE=Log::Log4perl::Appender::ScreenColoredLevels
    log4perl.appender.LOGFILE.mode = append
    log4perl.appender.LOGFILE.layout=PatternLayout
    log4perl.appender.LOGFILE.layout.ConversionPattern=[%d] %F{1}:%L$ %m%n
/;
    Log::Log4perl::init( \$logConf );
}

$myName =~ s/(.*)\..*/$1/;
my $logger = Log::Log4perl->get_logger($1);

# Options given to the program
my $optctl = {};

# Options description
my @optDesc = (
	       "help|?"
	      );

my $servingHost = "localhost:8080";
my $socksProxyOpt = "";
#my $socksProxyOpt = "--socks5 localhost:1080";

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
}

# -------------------------- checkArgs ---------------------------------
#  check command line arguments, set default values, exit on errors
# ------------------------------------------------------------------
sub checkArgs {
}

# -------------------------- getTime ---------------------------------
#  format a time stampl
# ------------------------------------------------------------------
sub getTime {
  return strftime "%Y-%b-%a-%T", localtime;
}


# -------------------------- MAIN ------------------------------
# Beginning of the script.
# --------------------------------------------------------------
$logger->info( "Starting at " . getTime() );

GetOptions( $optctl, @optDesc, "<>" => \&parseArg ) or printUsage( "", 2, 2 );
checkArgs($optctl);

my $parser = XML::LibXML->new();
my $contentQuery  = "//BomEntity//body/content";

#curl --socks5 localhost:1080 -X GET http://192.168.5.223:8080/search-2/serving/ -H Accept:text/xml;charset=UTF-8

my $lang="fr";
my $header = "-H \'Accept:text/xml;charset=UTF-8\' -H \'Accept-Language:$lang\'";
my $servingUrl = "http://" . $servingHost . "/search-2/serving";
my $infoUrl = "\'" . $servingUrl . "?facet=true&facet.field=contentType&rows=0\' " . $header;
my %contentTypes = ();
my $curlCmd = "curl -Ss $socksProxyOpt";
my $cmd = "$curlCmd -X GET $infoUrl";

#$logger->debug("$cmd");
open(CMD, "$cmd 2>&1 |" ) or die "can't run command: $cmd\n";

while (<CMD>) {
  #print("$_\n");
  chomp;
  while (/<facetCount\s+value="([^"]+)"\s+count="(\d+)"/g) {
    $contentTypes{$1} = $2;
  }
}
close (CMD);

my %sizes = ();
my $type;
my $typesFile = "./content_types.txt";
open(TYPES,">" . $typesFile) or die "can't open $typesFile";
TYPES->autoflush(1);
for  $type (keys(%contentTypes)) {
  print(TYPES "$type => " . $contentTypes{$type} . "\n");
  $logger->debug("$type => " . $contentTypes{$type});
}

for $type (keys(%contentTypes)) {
#for $type ("OldDownload") {
  #open(OUT,">./content_" . $type . "_" . $lang);
  my $sizeFile = "./content_" . $type . "_" . $lang;
  open(SIZE,">" . $sizeFile) or die "can't open $sizeFile";
  #$logger->debug("$type => " . $contentTypes{$type});
  my $start = 1;
  my $i = 0;
  my $step = 5000;
  while (($start <= $contentTypes{$type})) {
    print ("$i/" .  $contentTypes{$type} . " ");
    print ("\n") if (($i % ($step * 10)) == 0);

    my $xmlResp = "";
    my $getUrl = "\'" . $servingUrl . "?filter=contentType:$type&start=$start&rows=" . $step . "\' " . $header;
    my $cmd = "$curlCmd -X GET $getUrl";
    #$logger->debug("command: $cmd");
    $xmlResp = `$cmd`;
    #$logger->debug("\n+++++\n" . substr($xmlResp,0,10) . "..." . substr($xmlResp,,-10));
    my $doc    = $parser->parse_string($xmlResp);
    #$logger->debug($doc->toString(1));
    my $listContent = $doc->findnodes($contentQuery);
    #$logger->debug("Nb contents = " . $listContent->size());
    for my $content ($listContent->get_nodelist()) {
       #$logger->debug("\n****\n" . $content->textContent);
       my $size = int(length($content->textContent) / 10) * 10;
       #$logger->debug("$i => size = " . $size . " > " . substr($content->textContent,0,10) . "..." . substr($content->textContent,-10));
       #$sizes{$size} += 1;
       print(SIZE "$lang, $type , $size\n");
       $i++;
     }
    $start += $step;    
    #$logger->debug("start : $start, i : $i, step : $step, nbtype : " . $contentTypes{$type}) if (($i % 3) == 0);
  }
  $logger->debug("\n!!!!!!!!!!!!! END OF TYPE $type : expected : $contentTypes{$type}  / got : " . ($i + 1) . " !!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("\n");
  close(SIZE);
  print(TYPES "DONE : $type => " . $i);
}
close(TYPES);
%sizes = ();
