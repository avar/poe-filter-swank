# This code was adapted from POE::Filter::Stream by Rocco
package POE::Filter::Swank;
use strict;
use warnings;
use bytes ();
use POE::Filter;

our @ISA = ('POE::Filter');
our $VERSION = '0.01';

sub new
{
    my $type = shift;
    my $buffer = '';
    my $self = bless \$buffer, $type;
    $self;
}

sub clone
{
    my $self = shift;
    my $buffer = '';
    my $clone = bless \$buffer, ref $self;
}

sub get_one_start
{
    my ($self, $stream) = @_;
    $$self .= join '', @$stream;
}

sub get_one
{
    my $self = shift;
    return [ ] unless length $$self;
    my $chunk = $$self;
    $$self = '';

    my $length  = hex bytes::substr $chunk, 0, 6;
    my $content = bytes::substr $chunk, 6, $length;

    [ $content ];
}

sub put
{
    my ($self, $chunks) = @_;

    my $length = sprintf "%06x", bytes::length join '', @$chunks;

    [ $length, @$chunks ];
}

sub get_pending
{
    my $self = shift;
    return [ $$self ] if length $$self;
    undef;
}

1;

__END__

=head1 NAME

POE::Filter::Swank - Stream based filter for the Swank protocol

=head1 DESCRIPTION

The swank protocol is the protocol used by the Emacs part of SLIME to
communicate with its Lisp part, the swank server.

The protocol is a very simple stream based protocol where each message
is preceded by its length, e.g. Emacs might send this message at the
start of a SLIME session to get information about the Swank server:

   00002d(:emacs-rex (swank:connection-info) nil t 1)

To which the swank server might reply:

   00038E(:return (:ok (:pid 16581 :style :spawn :lisp-implementation [ message truncated ]

This filter takes care of stripping the length from incoming messages
and adding them to your outgoing messages, leaving you to worry only
about the sexps.

=head1 AUTHOR

E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avar@cpan.org>

=head1 LICENSE

Copyright 2008 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
