package Oak::Web::HTML::Script;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Visual);

=head1 NAME

Oak::Web::HTML::Script - SCRIPT HTML tag (Visual)

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::Script

=head1 PROPERTIES

=over

=item script

The Javascript source

=item Other properties

The Oak::Web::HTML::Style object has the properties defined by W3C

=back

=cut

sub valid_html_attributes {
	my $self = shift;
	(
	 "charset",
	 "type",
	 "src",
	 "defer"
  	);
}

sub show {
	my $self = shift;
	$self->SUPER::show;
	print "<SCRIPT";
	print $self->print_html_attributes;
	print ">".$self->get('script')."</SCRIPT>\n";
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
