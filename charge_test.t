use strict;
use warnings;

use Test::More 'no_plan';

use_ok 'BabySitterCharges';

my $bsc = new BabySitterCharges();

isa_ok($bsc, 'BabySitterCharges');
