package Oak::Web::HTML::B;

use strict;
use Error qw(:try);
use base qw(Oak::Web::HTML::PhraseElement);

=head1 NAME

Oak::Web::HTML::B - B HTML Tag

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::PhraseElement
  Oak::Web::HTML::B

=head1 PROPERTIES

The Oak::Web::HTML::B object has the following properties:

=over

=item caption

The text inside the tag

=item All other defined by W3C.

This component will use all the available properties following
the rules of HTML4.01

=back

=cut

sub load_initial_properties {
	my $self = shift;
	$self->set(type => "B");
}

1;

__END__

=head1 BUGS

Too early to determine. :)

=head1 COPYRIGHT

Copyright (c) 2001
Daniel Ruoso <daniel@ruoso.com>
All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
