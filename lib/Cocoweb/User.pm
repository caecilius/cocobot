# @created 2012-01-26
# @date 2012-06-26
# @author Simon Rubinstein <ssimonrubinstein1@gmail.com>
# http://code.google.com/p/cocobot/
#
# copyright (c) Simon Rubinstein 2010-2012
# Id: $Id: User.pm 282 2012-06-27 17:08:28Z ssimonrubinstein1@gmail.com $
# Revision: $Revision: 282 $
# Date: $Date: 2012-06-27 17:08:28 +0000 (Wed, 27 Jun 2012) $
# Author: $Author: ssimonrubinstein1@gmail.com $
# HeadURL: $HeadURL: http://cocobot.googlecode.com/svn/trunk/lib/Cocoweb/User.pm $
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
package Cocoweb::User;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use IO::File;
use POSIX;

use Cocoweb;
use Cocoweb::File;
use base 'Cocoweb::User::Base';

__PACKAGE__->attributes(
    'isNew',        'isView',         'dateLastSeen', 'hasChange',
    'notViewCount', 'updateDbRecord', 'DBCodeId',     'DBUserId'
);

##@method void init(%args)
#@brief Perform some initializations
sub init {
    my ( $self, %args ) = @_;
    confess error("Missing argument")
      if !exists $args{'mynickname'}
          or !exists $args{'myage'}
          or !exists $args{'mysex'}
          or !exists $args{'mynickID'}
          or !exists $args{'citydio'}
          or !exists $args{'mystat'}
          or !exists $args{'mystat'};
    debug(  'Creates new user "'
          . $args{'mynickname'}
          . '" (mynickID: '
          . $args{'mynickID'}
          . ')' );
    $self->attributes_defaults(
        'mynickname'     => $args{'mynickname'},
        'myage'          => $args{'myage'},
        'mysex'          => $args{'mysex'},
        'mynickID'       => $args{'mynickID'},
        'citydio'        => $args{'citydio'},
        'mystat'         => $args{'mystat'},
        'myXP'           => $args{'myXP'},
        'myver'          => $args{'myver'},
        'infuz'          => '???',
        'code'           => '',
        'ISP'            => '',
        'status'         => 0,
        'premium'        => 0,
        'level'          => 0,
        'since'          => 0,
        'town'           => '',
        'isNew'          => 1,
        'isView'         => 1,
        'dateLastSeen'   => time,
        'hasChange'      => 0,
        'notViewCount'   => 0,
        'updateDbRecord' => 0,
        'DBUserId'       => 0,
        'DBCodeId'       => 0,
        'messageCounter'  => 0,
        'messageSentTime' => 0,
        'messageLast'     => ''
    );
}

##@method boolean checkAndupdate(%args)
sub checkAndupdate {
    my ( $self, %args ) = @_;
    foreach my $name ( keys %args ) {
        my $newVal = $args{$name};
        my $oldVal = $self->$name();
        if ( $oldVal ne $newVal ) {
            $self->$name($oldVal);
            $self->updateDbRecord(1);
            info(   $self->mynickname()
                  . ': Replace "'
                  . $name
                  . '" from '
                  . $self->$name() . ' to '
                  . $newVal );
            $self->$name($newVal);
            next if $name eq 'mystat' or $name eq 'myXP' and $name eq 'myver';
            if ( $name eq 'mysex' ) {
                if (   ( $oldVal == 1 and $newVal == 6 )
                    or ( ( $oldVal == 6 and $newVal == 1 ) ) )
                {

                    #info("Sex is always masculine");
                    next;
                }
                if (   ( $oldVal == 2 and $newVal == 7 )
                    or ( $oldVal == 7 and $newVal == 2 ) )
                {

                    #info("Sex is always feminine.");
                    next;
                }
            }
            $self->hasChange(1);
        }
    }

    #debug(  $self->mynickname()
    #      . ' must be inserted in the database! Code: '
    #      . $self->DBCodeId() )
    #  if $self->hasChange();
    return $self->hasChange();
}

##@method void update(%args)
sub update {
    my ( $self, %args ) = @_;
    foreach my $name ( keys %args ) {
        $self->$name( $args{$name} );
    }
}

##@method void incNotViewCount()
sub incNotViewCount {
    my $self         = shift;
    my $notViewCount = $self->notViewCount();
    $notViewCount++;
    $self->notViewCount($notViewCount);
}

1;
