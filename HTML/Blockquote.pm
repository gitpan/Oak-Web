package Oak::Web::HTML::Blockquote;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Container);

=head1 NAME

Oak::Web::HTML::Blockquote - BLOCKQUOTE HTML tag (Container)

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::Container
  Oak::Web::HTML::Blockquote

=head1 PROPERTIES

The Oak::Web::HTML::Blockquote object has the properties defined by W3C

=cut

sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 $self->i18n_attributes,
	 $self->events_attributes,
	 "cite"
	);
}

sub start_container {
	my $self = shift;
	print "<BLOCKQUOTE";
	print $self->print_html_attributes;
	print ">\n";
}

sub end_container {
	print "</BLOCKQUOTE>\n";
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
