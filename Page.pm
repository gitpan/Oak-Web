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

=item expire_cookies

Boolean. If set will expire all the cookies of this session

=item script

Space for javascript

=back

=head1 EVENTS

=over

=item ev_onSyntaxError

This event is launched when some "check_syntax" has failed.  If you do syntax check, you probably
wants to define this event.

=item ev_onUncaughtError

This event is launched when some error occours when dispatching the events of the child components.
If this is not set and an uncaught error occours, the error will be propagated.

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
		}
		try {
			foreach my $k ($self->list_childs) {
				my $child = $self->get_child($k);
				$child->dispatch_all;
			}
		} catch Oak::Web::Page::Error::Syntax with {
			my $err = shift;
			if ($self->get('ev_onSyntaxError')) {
				$self->dispatch('ev_onSyntaxError');
			} else {
				throw $err;
			}
		} otherwise {
			my $err = shift;
			if ($self->get('ev_onUncaughtError')) {
				$self->dispatch('ev_onUncaughtError');
			} else {
				throw $err;
			}
		};
	}
	return 1;
}

=over

=item check_syntax(NAME,NAME,NAME,NAME)

Check the syntax of the components.
If some exception occours, the name of the
component that generated the exception will be added
in $self->{__ERRORS__}{name} = {error} and a
Oak::Web::Page::Error::Syntax will be thrown.

=back

=cut

sub check_syntax {
	my $self = shift;
	my @names = shift;
	my $err = 0;
	foreach my $k (@names) {
		my $child = $self->get_child($k);
		try {
			$child->check_syntax;
		} otherwise {
			my $e = shift;
			$err = 1;
			$self->{__ERRORS__}{$k} = $e->stringify;
		}
	}
	if ($err) {
		throw Oak::Web::Page::Error::Syntax;
	} else {
		return 1;
	}
}

sub start_container {
	my $self = shift;
	my %cookies_params = $self->get_cookies_properties;
	if ($self->get('expire_cookies')) {
		$::SESSION->mark_all_cookies;
		$cookies_params{"-expires"} = "-1d";
	}
	my $ar_cookies = $::SESSION->get_cookies(%cookies_params);
	$ar_cookies ||= [];
	foreach my $c (@{$ar_cookies}) {
		print "Set-Cookie: $c\n";
	}
	print "Content-type: text/html\n\n";
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

=over

=item get_cookies_properties

Return a HASH with the default properties of the cookies

=back

=cut;

sub get_cookies_properties {
	()
}

=head1 EXCEPTIONS

The following exceptions are introduced by Oak::Component

=over

=item Oak::Web::Page::Error::Syntax

This error is thrown by check_syntax telling that some test was wrong.

=back

=cut

package Oak::Web::Page::Error::Syntax;
use base qw (Error);

sub stringify {
	return "Syntax Error";
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
