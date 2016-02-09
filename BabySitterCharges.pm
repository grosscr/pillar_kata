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

    my @tmp = split(':',$start_time);
    my $hour = $tmp[0];

    # Add 12 to the hour if it's in the PM
    if ( $start_time ~~ /[PM]/ ) {
        $hour += 12;
    }

    if ( $hour >= 17 ) {
        $self->{start_time} = $start_time;
        $self->{start_hour} = $hour;
        return 1;
    }
    else {
        # Don't save it if it's before 5 PM
        $self->{start_time} = undef;
        $self->{start_hour} = undef;
        return 0;
    }
}

sub get_start_time() {
    my ( $self ) = @_;
    return $self->{start_time};
}

1;
