#! /bin/perl
# -*-cperl-*-

use strict;
use Cwd;
use Tem::Menu
use File::Basename;
use Getopt::Long (":config", "no_ignore_case", "gnu_getopt");

$|=1;
# What's my name?
my $myName = File::Basename::basename ($0);    
my $myDir = Cwd::abs_path(File::Basename::dirname($0));

# include local libraries.
#push(@INC,$myDir);

# Options given to the program
my %optctl = ();
# Options description
my @optDesc = ();

my ($sshHost,$nbArgs);

# -------------------------- usage ---------------------------------
#  print how to use the script
# ------------------------------------------------------------------
sub usage($@)  {
  my ($cause,@others) = @_;
  print(STDERR "\t$cause \n");
  print(STDERR "$myName [host_alias]\n");
  print(STDERR "\t ssh to a host selected throw a menu or given as parameter\n");
  print(STDERR "\t if there is a parameter try to match it to a host alias or try to connect directly to it\n");
  print(STDERR "\t Try to issue the ssh in the more convinient terminal given the environment where it is run: screen, new Kterm or new emacs tab\n");
  exit(1);
}

# -------------------------- checkArgs ---------------------------------
#  check command line arguments
# ------------------------------------------------------------------
sub checkArgs() {
}

# -------------------------- parseArg ---------------------------------
#  parse an non option argument
# ------------------------------------------------------------------
sub parseArg($) {
  if ($nbArgs > 0) {
    usage("only one argument supported");
  }
  $nbArgs++;
  ($sshHost) = @_; 
}

# -------------------------- selectHost ---------------------------------
#  display a menu to select the host
# ------------------------------------------------------------------
sub selectHost() {

  $Heading="\nSelect a host to connect to\n";
  $Prompt="\nEnter host Number (^C-d to exit):";
  my $choice;
  select $choice (keys(%hosts)) {
    last;
  }
  return $choice;
}

# -------------------------- MAIN ------------------------------
# Beginning of the script.
# ------------------------------------------------------------------

# getting arguments : non options arguments will be parse by parseArgs sub.
GetOptions (\%optctl,@optDesc,"<>" => \&parseArg) or usage($!);
# Check command line arguments
checkArgs();

my $cwd = Cwd::cwd();

# Initialise the environment
my $choice;
if (!defined $sshHost) {
  $choice = selectHost() or print("no host selected\n") and exit;
  $sshHost = $hosts{$choice}[1];
}

my $cmd = "screen -T xterm -a -O -U -t \"" . $hosts{$choice}[0] . "_$$\" ssh ech\@$sshHost";
print ("connecting to host $sshHost: $cmd ...\n");

system ("$cmd");
