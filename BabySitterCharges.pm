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

    return 0 unless $start_time && $start_time =~ /\:/;

    my @tmp = split(':',$start_time);
    my $hour = $tmp[0];

    # Add 12 to the hour if it's in the PM
    if ( $start_time =~ /PM/ ) {
        $hour += 12;
    }

    if ( $hour >= 17 ) {
        $self->{start_time} = $start_time;
        $self->{start_hour} = $hour;
        return 1;
    }
    else {
        # Don't save it if it's before 5 PM
        return 0;
    }
}

sub set_end_time($) {
    my ( $self, $end_time ) = @_;

    return 0 unless $end_time && $end_time =~ /\:/;

    my @tmp = split(':',$end_time);
    my $hour = $tmp[0];

    # Add 12 to the hour if it's in the PM
    if ( $end_time =~ /PM/ ) {
        $hour += 12;
    }
    elsif ( $hour < 12 ) {
        # It's in the morning, so make the hour be for
        # the next day so subtracting is easier later
        $hour += 24;
    }

    if ( $hour <= 28 ) {
        $self->{end_time} = $end_time;
        $self->{end_hour} = $hour;
        return 1;
    }
    else {
        # Don't save it if it's after 4 AM
        return 0;
    }
}

sub set_bed_time($) {
    my ( $self, $bed_time ) = @_;

    return 0 unless $bed_time && $bed_time =~ /\:/;

    # Can't set bedtime unless we have start and end time
    return 0 unless $self->{start_time} && $self->{end_time};

    my @tmp = split(':',$bed_time);
    my $hour = $tmp[0];

    # Add 12 to the hour if it's in the PM
    if ( $bed_time =~ /PM/ ) {
        $hour += 12;
    }

    if ( $hour > $self->{start_hour} && $hour < $self->{end_hour} ) {

        if ( $hour >= 24 ) {
            # No kid that still needs babysat
            # should be up past midnight
            return 0;
        }
        $self->{bed_time} = $bed_time;
        $self->{bed_hour} = $hour;
        return 1;
    }
    else {
        # Don't save it if it's not between the start and end times
        return 0;
    }
}

sub get_start_time() {
    my ( $self ) = @_;
    return $self->{start_time};
}

sub get_end_time() {
    my ( $self ) = @_;
    return $self->{end_time};
}

sub get_bed_time() {
    my ( $self ) = @_;
    return $self->{bed_time};
}

###### Functions for testing only ######

sub get_start_hour() {
    my ( $self ) = @_;
    return $self->{start_hour};
}

sub get_end_hour() {
    my ( $self ) = @_;
    return $self->{end_hour};
}

sub get_bed_hour() {
    my ( $self ) = @_;
    return $self->{bed_hour};
}
1;
