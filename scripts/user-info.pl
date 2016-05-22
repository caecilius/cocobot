#!/usr/bin/perl
# @brief Get the number of days left of Premium subscription
# @created 2012-03-03
# @date 2014-08-09
# @author Simon Rubinstein <ssimonrubinstein1@gmail.com>
# http://code.google.com/p/cocobot/
#
# copyright (c) Simon Rubinstein 2010-2014
# Id: $Id: user-info.pl 589 2014-07-09 19:28:13Z ssimonrubinstein1 $
# Revision: $Revision: 589 $
# Date: $Date: 2014-07-09 19:28:13 +0000 (Wed, 09 Jul 2014) $
# Author: $Author: ssimonrubinstein1 $
# HeadURL: $HeadURL: http://cocobot.googlecode.com/svn/trunk/scripts/user-info.pl $
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
use FindBin qw($Script $Bin);
use Data::Dumper;
use utf8;
no utf8;
use lib "../lib";
use Cocoweb;
use Cocoweb::CLI;
my $CLI;

init();
run();

##@method void run
sub run {
    my $bot = $CLI->getBot( 'generateRandom' => 1 );
    $bot->requestAuthentication();
    $bot->requestUserInfuz();
    $bot->show();
    $bot->requestConnectedUserInfo();
    info("The $Bin script was completed successfully.");
}

##@method void init()
sub init {
    $CLI = Cocoweb::CLI->instance();
    my $opt_ref = $CLI->getOpts();
    if ( !defined $opt_ref ) {
        HELP_MESSAGE();
        exit;
    }
}

## @method void HELP_MESSAGE()
# Display help message
sub HELP_MESSAGE {
    print STDOUT $Script
      . ', Get the number of days left of Premium subscription' . "\n";
    $CLI->printLineOfArgs();
    $CLI->HELP();
    exit 0;
}

##@method void VERSION_MESSAGE()
#@brief Displays the version of the script
sub VERSION_MESSAGE {
    $CLI->VERSION_MESSAGE('2014-08-09');
}

