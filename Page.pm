package Oak::Web::Page;

use strict;
use Error qw(:try);
use base qw(Oak::Web::Container);

=head1 NAME

Oak::Web::Page - Top level component of a web application

=head1 DESCRIPTION

This class is the web page itself.

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::Container
  Oak::Web::Page

=head1 PROPERTIES

The Oak::Web::Page object has the following properties:

=over

=item lang

Language of the HTML code

=item dir

Text direction (left to right or right to left

=item title

The title of this web page

=item meta

This property contains the text to include as meta information (as is, including the tag, but not < nor >)

=item linkrel

This property contains the text to include as linkrel (as is, including the tag, but not < nor >)

=item style

Space for stylesheet

=item script

Space for javascript

=back

=head1 METHODS

=over

=item message(NAME => VALUE)

receives a message from the application.
In this module the only message is POST which receives the CGI object.

=back

=cut

sub message {
	my $self = shift;
	my %parms = @_;
	if ($parms{POST}) {
		my $cgi = $parms{POST};
		my $err = 0;
		foreach my $k ($self->list_childs) {
			my $child = $self->get_child($k);
			$child->receive_cgi($cgi);
			try {
				$child->check_syntax;
			} otherwise {
				$err = 1;
				$child->set('hasError' => 1);
			}
		}
		if (!$err) {
			foreach my $k ($self->list_childs) {
				my $child = $self->get_child($k);
				$child->dispatch;
			}
		} else {
			$self->show;
		}
	}
}

sub start_container {
	my $self = shift;
	#print "Content-type: text/html\n\n";
	print "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n";
        print "  \"http://www.w3.org/TR/html4/strict.dtd\">\n";
	print "<HTML";
	if ($self->get('lang')) {
		print " lang=\"".$self->get('lang')."\"";
	}
	if ($self->get('dir')) {
		print " dir=\"".$self->get('dir')."\"";
	}
	print ">\n";
	print "<HEAD>\n";
	print "<TITLE>".$self->get('title')."</TITLE>\n";
	print "<".$self->get('meta').">\n" if $self->get('meta');
	print "<".$self->get('linkrel').">\n" if $self->get('linkrel');
	print "<STYLE>".$self->get('style')."</STYLE>\n" if $self->get('style');
	print "<SCRIPT><!--\n".$self->get('script')."\n--></SCRIPT>\n" if $self->get('script');
	print "</HEAD>\n";
}

sub end_container {
	print "</HTML>\n";
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
