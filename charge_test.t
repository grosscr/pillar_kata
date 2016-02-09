use strict;
use warnings;

use Test::More 'no_plan';

use_ok 'BabySitterCharges';

my $bsc = new BabySitterCharges();

isa_ok($bsc, 'BabySitterCharges');

ok($bsc->set_start_time("5:00 PM"), "Setting start time to 5:00 PM is successful");
is($bsc->get_start_time(), "5:00 PM", "Retrieve start time of 5:00 PM");

ok(!$bsc->set_start_time("4:00 PM"), "Setting start time to 4:00 PM is un-successful");
isnt($bsc->get_start_time(), "4:00 PM", "Verify start time didn't save");
