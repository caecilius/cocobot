#!/usr/bin/perl
# @created 2012-03-23
# @date 2014-02-15
# @author Simon Rubinstein <ssimonrubinstein1@gmail.com>
# http://code.google.com/p/cocobot/
#
# copyright (c) Simon Rubinstein 2010-2014
# Id: $Id: checks-if-nickname-is-offline.pl 488 2014-02-15 16:14:18Z ssimonrubinstein1 $
# Revision: $Revision: 488 $
# Date: $Date: 2014-02-15 16:14:18 +0000 (Sat, 15 Feb 2014) $
# Author: $Author: ssimonrubinstein1 $
# HeadURL: $HeadURL: http://cocobot.googlecode.com/svn/trunk/scripts/checks-if-nickname-is-offline.pl $
#
# cocobot is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# cocobot is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA  02110-1301, USA.
use strict;
use warnings;
use Data::Dumper;
use FindBin qw($Script $Bin);
use utf8;
no utf8;
use lib "../lib";
use Cocoweb;
use Cocoweb::CLI;
my $CLI;
my $maxOfLoop = 1;

init();
run();

##@method void run()
sub run {
    my $bot = $CLI->getBot( 'generateRandom' => 1 );
    $bot->requestAuthentication();
    $bot->display();
    my $userWanted = $CLI->getUserWanted($bot);
    return if !defined $userWanted;
    for ( my $i = 1; $i <= $CLI->maxOfLoop(); $i++ ) {
        message( "Loop $i / " . $CLI->maxOfLoop() );
        $bot->setTimz1($i);
        $bot->requestMessagesFromUsers();
        $bot->requestsChecksIfUserOffline( [$userWanted] );
        sleep $CLI->delay();
    }
}

##@method void init()
#@brief Perform some initializations
sub init {
    $CLI = Cocoweb::CLI->instance();
    my $opt_ref = $CLI->getOpts( 'searchEnable' => 1, 'enableLoop' => 1 );
    if ( !defined $opt_ref ) {
        HELP_MESSAGE();
        exit;
    }
}

## @method void HELP_MESSAGE()
# Display help message
sub HELP_MESSAGE {
    print STDOUT $Script
        . ', Checks whether a user has logged out of Coco.fr' . "\n";
    $CLI->printLineOfArgs();
    $CLI->HELP();
    exit 0;
}

##@method void VERSION_MESSAGE()
#@brief Displays the version of the script
sub VERSION_MESSAGE {
    $CLI->VERSION_MESSAGE('2014-02-15');
}
