package Oak::Web::HTML::Frameset;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Container);

=head1 NAME

Oak::Web::HTML::Frameset - A frameset tag

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::Container
  Oak::Web::HTML::Frameset

=head1 PROPERTIES


The Oak::Web::HTML::Frameset object has the properties defined by W3C

=cut

sub valid_html_attributes {
	my $self = shift;
	(
	 $self->core_attributes,
	 "longdesc",
	 "name",
	 "src",
	 "frameborder",
	 "marginwidth",
	 "marginheight",
	 "noresize",
	 "scrolling"
	);
}

sub start_container {
	my $self = shift;
	print "<FRAMESET";
	print $self->print_html_attributes;
	print ">\n";
}

sub end_container {
	print "</FRAMESET>";
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
