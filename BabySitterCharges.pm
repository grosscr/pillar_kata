package BabySitterCharges;

use strict;
use warnings;

sub new {
    my ( $class, %args ) = @_;

    my $self = bless{}, $class;
    return $self;
};

sub set_start_time($) {
    return 1;
}

1;
