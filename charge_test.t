use strict;
use warnings;

use Test::More 'no_plan';

use_ok 'BabySitterCharges';

my $bsc = new BabySitterCharges();

isa_ok($bsc, 'BabySitterCharges');

# Tests for setting start time
ok($bsc->set_start_time("5:00 PM"), "Setting start time to 5:00 PM is successful");
is($bsc->get_start_time(), "5:00 PM", "Retrieve start time of 5:00 PM");
is($bsc->get_start_hour(), 17, "Got 17 as hour for start time");

$bsc = new BabySitterCharges();
ok(!$bsc->set_start_time("4:00 PM"), "Setting start time to 4:00 PM is un-successful");
is($bsc->get_start_time(), undef, "Verify start time didn't save");
is($bsc->get_start_hour(), undef, "Verify start hour didn't save");

# Tests for setting end time
$bsc = new BabySitterCharges();
ok($bsc->set_end_time("4:00 AM"), "Setting end time to 4:00 AM is successful");
is($bsc->get_end_time(), "4:00 AM", "Retrieve end time of 4:00 AM");
is($bsc->get_end_hour(), 28, "Got 28 as hour for end time");

$bsc = new BabySitterCharges();
ok(!$bsc->set_end_time("5:00 AM"), "Setting end time to 5:00 AM is un-successful");
is($bsc->get_end_time(), undef, "Verify end time didn't save");
is($bsc->get_end_hour(), undef, "Verify end hour didn't save");

# Test military time
$bsc = new BabySitterCharges();
$bsc->set_start_time("18:00");
is($bsc->get_start_time(), "18:00", "Retrieved start time of 18:00");
is($bsc->get_start_hour(), "18", "Got 18 as hour for start time");

$bsc = new BabySitterCharges();
$bsc->set_end_time("23:00");
is($bsc->get_end_time(), "23:00", "Retrieved end time of 23:00");
is($bsc->get_end_hour(), "23", "Got 23 as hour for end time");

# Test invalid time
$bsc = new BabySitterCharges();
ok(!$bsc->set_start_time('abc'), "Fail to set start time for invalid time");
ok(!$bsc->set_start_time('16'), "Fail to set start time for invalid time");
ok(!$bsc->set_start_time(), "Fail to set start time for invalid time");
ok(!$bsc->set_end_time('abc'), "Fail to set end time for invalid time");
ok(!$bsc->set_end_time('16'), "Fail to set end time for invalid time");
ok(!$bsc->set_end_time(), "Fail to set end time for invalid time");
ok(!$bsc->set_bed_time('abc'), "Fail to set bed time for invalid time");
ok(!$bsc->set_bed_time('16'), "Fail to set bed time for invalid time");
ok(!$bsc->set_bed_time(), "Fail to set bed time for invalid time");

# Setting bed time

$bsc = new BabySitterCharges();
ok(!$bsc->set_bed_time("9:00 PM"), "Fail to set bedtime when there's no start or end time");
$bsc->set_start_time("5:00 PM");
ok(!$bsc->set_bed_time("9:00 PM"), "Fail to set bedtime when there's no end time");

$bsc = new BabySitterCharges();
$bsc->set_end_time("1:00 AM");
ok(!$bsc->set_bed_time("9:00 PM"), "Fail to set bedtime when there's no start time");

$bsc = new BabySitterCharges();
$bsc->set_start_time("8:00 PM");
$bsc->set_end_time("1:00 AM");

ok(!$bsc->set_bed_time("7:00 PM"), "Fail to set bedtime when it's not between start and end time");
is($bsc->get_bed_time(), undef, "Verify set bed time didn't save");
is($bsc->get_bed_hour(), undef, "Verify set bed hour didn't save");

ok(!$bsc->set_bed_time("12:00 PM"), "Fail to set bedtime if it's midnight");
is($bsc->get_bed_time(), undef, "Verify set bed time didn't save");
is($bsc->get_bed_hour(), undef, "Verify set bed hour didn't save");

ok(!$bsc->set_bed_time("1:00 AM"), "Fail to set bedtime if it's after midnight");
is($bsc->get_bed_time(), undef, "Verify set bed time didn't save");
is($bsc->get_bed_hour(), undef, "Verify set bed hour didn't save");

ok($bsc->set_bed_time("10:00 PM"), "Setting bed time between start and end time successful");
is($bsc->get_bed_time(), "10:00 PM", "Retrieve bed time of 10:00 PM");
is($bsc->get_bed_hour(), "22", "Got 22 as hour for bed time");

is($bsc->calculate(), '$56.00', 'Got $56.00 for the night');

$bsc = new BabySitterCharges();
$bsc->set_start_time("5:00 PM");
$bsc->set_end_time("4:00 AM");
$bsc->set_bed_time("9:00 PM");

is($bsc->calculate(), '$136.00', 'Got $136.00 for the night');
