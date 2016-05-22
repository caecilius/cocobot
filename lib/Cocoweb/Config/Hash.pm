# @created 2012-02-18
# @date 2012-02-18
# @author Simon Rubinstein <ssimonrubinstein1@gmail.com>
# http://code.google.com/p/cocobot/
#
# copyright (c) Simon Rubinstein 2010-2012
# Id: $Id: Hash.pm 51 2012-02-18 20:53:38Z ssimonrubinstein1@gmail.com $
# Revision: $Revision: 51 $
# Date: $Date: 2012-02-18 20:53:38 +0000 (Sat, 18 Feb 2012) $
# Author: $Author: ssimonrubinstein1@gmail.com $
# HeadURL: $HeadURL: http://cocobot.googlecode.com/svn/trunk/lib/Cocoweb/Config/Hash.pm $
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
package Cocoweb::Config::Hash;
use strict;
use warnings;
use Cocoweb;
use Carp;
use Data::Dumper;

use base 'Cocoweb::Config::Base';

__PACKAGE__->attributes('all');

## @method void init($args)
sub init {
    my ( $self, %args ) = @_;
    croak error('Error: Required parameter "hash" is missing!')
      if !exists $args{'hash'};
    $self->all( $args{'hash'} );
}
1;
