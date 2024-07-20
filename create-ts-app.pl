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
    my $add_cmd = "npm install";
    $add_cmd = "yarn add" if `sh -c 'command -v yarn'`;
    $add_cmd = "pnpm install" if `sh -c 'command -v pnpm'`;

    my $pm = (split " ", $add_cmd)[0];

    print colored("Setting up TS in '" . getcwd() . "' with '$pm'\n", $YELLOW);
    system($add_cmd . ' typescript --save-dev');
    system('npx tsc --init');
    system(q{echo 'console.log("Hello World!");' > index.ts});
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
