package BabySitterCharges;

use strict;
use warnings;

sub new {
    my ( $class, %args ) = @_;

    my $self = bless{}, $class;
    return $self;
};

sub set_start_time($) {
    my ( $self, $start_time ) = @_;
    $self->{start_time} = $start_time;
    return 1;
}

sub get_start_time() {
    my ( $self ) = @_;
    return $self->{start_time};
}

1;
