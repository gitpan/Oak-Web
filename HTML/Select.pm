package Oak::Web::HTML::Select;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Container);

=head1 NAME

Oak::Web::HTML::Select - A Select component

=head1 HIERARCHY

L<Oak::Object|Oak::Object>

L<Oak::Persistent|Oak::Persistent>

L<Oak::Component|Oak::Component>

L<Oak::Web::Visual|Oak::Web::Visual>

L<Oak::Web::Container|Oak::Web::Container>

L<Oak::Web::HTML::Select|Oak::Web::HTML::Select>


=head1 PROPERTIES

value: The default selected option

The Oak::Web::HTML::Select object has the properties defined by W3C

=head1 EVENTS

ev_onChange: When the selected item was changed.

=cut

sub receive_cgi {
	my $self = shift;
	my $cgi = shift;
	my $oldtext = $self->get('value');
	$self->set('value' => $cgi->param($self->get('name')));
	if ($oldtext ne $self->get('value')) {
		$self->{__events__}{ev_onChange} = 1;
	}
	return 1;
}


sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 $self->i18n_attributes,
	 $self->events_attributes,
	 "name",
	 "size",
	 "multiple",
	 "disabled",
	 "tabindex",
	 "onfocus",
	 "onblur",
	 "onchange"
	);
}

sub start_container {
	my $self = shift;
	print "<SELECT";
	print $self->print_html_attributes;
	print ">\n";
}

sub end_container {
	print "</SELECT>\n";
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
