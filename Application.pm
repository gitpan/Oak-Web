package Oak::Web::Application;

use strict;
use base qw(Oak::Application);

=head1 NAME

Oak::Application - Class for creating applications in Oak

=head1 SYNOPSIS

  my $app = new Oak::Web::Application
    (
     "MyApp::page1" => "page1.xml",
     "MyApp::page2" => "page2.xml",
     "MyApp::page3" => "page3.xml",
     "default" => "MyApp::page1"
    );

  $app->run(mode => CGI);

  # OR

  $app->run(mode => FCGI);

  # OR

  $app->run;			# will use mode => FCGI

=head1 DESCRIPTION

This is the class that will be used to create real applications,
the executable file will launch it.

=head1 METHODS

=over

=item run

Runs the application, receives the requests and pass to the toplevel
components.

  Oak::Web::Application generates the message (POST => $cgiobj)

The request must have the "__owa_origin__" parameter to distinguish
which toplevel component to use.

=back

=cut

sub run {
	my $self = shift;
	my $mode = shift;
	$mode = "FCGI" unless $mode =~ /^(CGI|FCGI)$/;
	my $class;
	if ($mode eq "FCGI") {
		$class = "CGI::Fast";
	} else {
		$class = "CGI";
	}
	eval "require $class" || throw Oak::Web::Application::Error::BrokenDependencies;
	while (my $cgi = $class->new) {
		my $origin = $cgi->param('__owa_origin__');
		if (eval 'die unless defined $::TL::'.$origin) {
			eval '$::TL::'.$origin.'->message(POST => $cgi)';
		} else {
			$::TL::default->message(POST => $cgi);
		}
	}
}

=head1 EXCEPTIONS

The following exceptions are introduced by Oak::Web::Application

=over

=item Oak::Web::Application::Error::BrokenDependencies

You tryied to user or CGI or FCGI, but it failed to require
or "CGI" or "CGI::Fast".

=back

=cut

package Oak::Web::Application::Error::BrokenDependencies;
use base qw (Error);

sub stringify {
	return "Broken dependencies while trying to load 'CGI' or 'CGI::Fast'";
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
