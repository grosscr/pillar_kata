use strict;
use warnings;

use Test::More 'no_plan';

use_ok 'BabySitterCharges';

my $bsc = new BabySitterCharges();

isa_ok($bsc, 'BabySitterCharges');

ok($bsc->set_start_time("5:00 PM"), "Setting start time to 5:00 PM is successful");
ok($bsc->get_start_time(), "Retrieve start time of 5:00 PM");
