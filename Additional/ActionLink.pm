package Oak::Web::Additional::ActionLink;

use strict;
use Error qw(:try);
use base qw(Oak::Web::HTML::A);

=head1 NAME

Oak::Web::Additional::ActionLink - A link associated with an action

=head1 DESCRIPTION

A container that holds a link with a ev_onClick event.
This link will be received and will dispatch an event in Oak.

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::Container
  Oak::Web::HTML::A
  Oak::Web::Additional::ActionLink

=head1 PROPERTIES

The Oak::Web::HTML::A object has the properties defined by W3C.
but the property application and the property params overrides
the href property.

P.S.: When an action link is clicked, no form is submitted. If
you want to submit a form with a link, use the traditional
Oak::Web::HTML::A and define a javascript function.

=over

=item application

The url of this web application

=item params

Another params (in URL encoded format) to add to the link

=back

=head1 EVENTS

=over

=item ev_onClick

This event is dispatched when this link is clicked.

=back

=cut

sub receive_cgi {
	my $self = shift;
	my $cgi = shift;
	if ($cgi->param($self->get('name'))) {
		$self->{__events__}{ev_onClick} = 1;
	}
	return 1;
}



sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 $self->i18n_attributes,
	 $self->events_attributes,
	 "charset",
	 "type",
	 "name",
	 "href",
	 "hreflang",
	 "rel",
	 "rev",
	 "accesskey",
	 "shape",
	 "coords",
	 "tabindex",
	 "onfocus",
	 "onblur"
  	);
}

sub start_container {
	my $self = shift;
	$self->set
	  (
	   'href' =>
	   $self->get('application').
	   '?__owa_origin__='.$self->{__owner__}->get('name').'&'.
	   $self->get('name').'=true&'.$self->get('params')
	  );
	print "<A";
	print $self->print_html_attributes;
	print ">\n";
}

sub end_container {
	print "</A>\n";
}

1;

__END__

=head1 COPYRIGHT

Copyright (c) 2001
Daniel Ruoso <daniel@ruoso.com>
All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
