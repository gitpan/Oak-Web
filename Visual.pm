package Oak::Web::Visual;

use strict;
use Error qw(:try);
use base qw(Oak::Component);

=head1 NAME

Oak::Visual - Superclass for all visual web components

=head1 DESCRIPTION

This class implements all the necessary methods for a visual component.

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual

=head1 PROPERTIES

All the visual components must have the following properties:

=over

=item parent

The name of the object which this component will be shown inside.

=item top

The order from top to bottom in which this component will be shown.

=item left

The order from left to right in which this component will be shown.

=item hasError

This component found an error in the last checkSyntax.

=back

=head1 METHODS

=over

=item receive_cgi(CGIOBJ)

This method is called to restore the state of the page when the client
submits. This function will not do anything but setting the components
properties

=back

=cut

sub receive_cgi {
	return 1;
}

=over

=item check_syntax

This method should throw an exception when the syntax of one of the
input fields is wrong. The text of the exception will be shown.

=back

=cut

sub check_syntax {
	return 1;
}

=over

=item dispatch

This method will see if any event must be started by this component.
I.e.: if a submit button was clicked, test if there is an event for
this button and then launch the event.
This method must not be overrided. To dispatch an event, just set
$self->{__events__}{EVENTNAME} = 1, and this function will automatically
dispatch the event.

=back

=cut

sub dispatch {
	my $self = shift;
	$self->{__events__} ||= {};
	foreach my $ev (keys %{$self->{__events__}}) {
		if ($self->get($ev)) {
			eval $self->get($ev);	
		}
	}
	return 1;
}

=over

=item valid_html_attributes

This function returns an array with all the properties that can be used
as a valid html attribute for this component

=back

=cut

sub valid_html_attributes {
	(
	);
}

=over

=item core_attributes

Return the %coreattr elements as defined by W3C.

=back

=cut

sub core_attributes {
	qw(
	   id
	   class
	   style
	   title
	  );
}

=over

=item i18n_attributes

Return the %i18n elements as defined by W3C.

=back

=cut

sub i18n_attributes {
	qw(
	   lang
	   dir
	  );
}

=over

=item events_attributes

Return the %events elements as defined by W3C.

=back

=cut

sub events_attributes {
	(
	 "onclick",
	 "ondblclick",
	 "onmousedown",
	 "onmouseup",
	 "onmouseover",
	 "onmousemove",
	 "onmouseout",
	 "onkeypress",
	 "onkeydown",
	 "onkeyup"
	);
}	


=over

=item cellhalgin_attributes

Return the %cellhalign elements as defined by W3C.

=back

=cut

sub cellhalign_attributes {
	qw(
	   align
	   char
	   charoff
	  );
}

=over

=item cellvalgin_attributes

Return the %cellvalign elements as defined by W3C.

=back

=cut

sub cellvalign_attributes {
	qw(
	   valign
	  );
}

=over

=item print_html_attributes

Automatically print all the valid html attributes

=back

=cut

sub print_html_attributes {
	my $self = shift;
	foreach my $p ($self->valid_html_attributes) {
		if ($self->get($p)) {
			print " ".$p."=\"".$self->get($p)."\"";
		}
	}
}

=over

=item show

Show the component (print it to output), and launch (if necessary) an
ev_onShow event. Hint: Oak::Web::Visual already launchs the ev_onShow, so,
when you implement a visual component, try to call SUPER.

=back

=cut

sub show {
	my $self = shift;
	if ($self->get('ev_onShow')) {
		eval $self->get('ev_onShow');	
	}
	return 1;
}


1;

__END__

=head1 EXAMPLES

  use base qw(Oak::Web::Visual);

=head1 COPYRIGHT

Copyright (c) 2001
Daniel Ruoso <daniel@ruoso.com>
All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.