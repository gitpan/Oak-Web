package Oak::Web::HTML::Label;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Visual);

=head1 NAME

Oak::Web::HTML::Label - A Label Tag

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::Label

=head1 PROPERTIES

The Oak::Web::HTML::Label object has the following properties:

=over

=item caption

The text inside the tag

=back

And any other defined by W3C

=cut

sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 $self->i18n_attributes,
	 $self->events_attributes,
	 "for",
	 "accesskey",
	 "onfocus",
	 "onblur"
  	);
}

sub show {
	my $self = shift;
	$self->SUPER::show;
	print "<LABEL";
	print $self->print_html_attributes;
	print ">\n".$self->get('caption')."</LABEL>";
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