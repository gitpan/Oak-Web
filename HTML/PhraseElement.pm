package Oak::Web::HTML::PhraseElement;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Visual);

=head1 NAME

Oak::Web::HTML::PhraseElement - Base for PhraseElements (defined by W3C)

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::PhraseElement

=head1 PROPERTIES

The Oak::Web::HTML::PhraseElement object has the following properties:

=over

=item type

One of:

  EM | STRONG | DFN | CODE | SAMP | KBD | VAR | CITE | ABBR | ACRONYM
  TT | I | B | BIG | SMALL

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
	print "<".$self->get('type');
	$self->print_html_attributes;
	print ">".$self->get('caption')."</".$self->get('type').">\n";
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
