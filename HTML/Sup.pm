package Oak::Web::HTML::Sup;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Visual);

=head1 NAME

Oak::Web::HTML::Sup - SUB HTML Tag

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::Sup

=head1 PROPERTIES

The Oak::Web::HTML::Sup object has the following properties:

=over

=item caption

The text inside the tag

=item All other defined by W3C.

This component will use all the available properties following
the rules of HTML4.01

=back

=cut

sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 $self->i18n_attributes,
	 $self->events_attributes
	);
}

sub show {
	my $self = shift;
	$self->SUPER::show;
	print "<SUP";
	$self->print_html_attributes;
	print ">".$self->get('caption')."</SUP>\n";
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
