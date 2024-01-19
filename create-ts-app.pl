#!/usr/bin/env perl

use strict;
use warnings;
use File::Path qw( make_path );
use Cwd qw( getcwd );
use Term::ANSIColor;

my $RED = "red";
my $GREEN = "green";
my $YELLOW = "yellow";

sub create_ts_project {
    print colored("Setting up TS in '" . getcwd() . "' ...\n", $YELLOW);
    system('npm i typescript --save-dev');
    system('npx tsc --init');
    print colored("Done\n", $GREEN);
}

sub main {
    my $name = $ARGV[0];
    if ($name) {
        if (-d $name) {
            die colored("Directory '$name' already exists.", $RED) . "\n";
        }
        make_path($name);
        chdir($name);
    }
    create_ts_project();
}

main();
