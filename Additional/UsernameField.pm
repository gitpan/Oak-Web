package Oak::Web::Additional::UsernameField;

use strict;
use Error qw(:try);
use base qw(Oak::Web::HTML::Input);

=head1 NAME

Oak::Web::Additional::UsernameField - Component to create a username field

=head1 DESCRIPTION

This component creates a username field. The input will have the size of 8
by default. And will accept only [a-zA-Z0-9\.\_\-].

The type of the input *is* text.

=head1 HIERARCHY

  Oak::Object
  Oak::Persistent
  Oak::Component
  Oak::Web::Visual
  Oak::Web::HTML::Input
  Oak::Web::Additional::UsernameField

=head1 PROPERTIES

=over

=item required

If true, then the field must be filled, else not.

=back

=cut

sub constructor {
	my $self = shift;
	my %params = @_;
	if (ref $params{RESTORE} eq "HASH") {
		$params{RESTORE}{size} ||= "8";
	}
	$self->SUPER::constructor(%params);
}

sub show {
	my $self = shift;
	$self->set('type' => 'text');
	$self->SUPER::show;
}

sub check_syntax {
	my $self = shift;
	if (!$self->get('value') && $self->get('required')) {
		throw Oak::Error::ParamsMissing;
	} elsif (!$self->get('value') && !$self->get('required')) {
		return 1;
	} else {
		if ($username =~ /[^a-zA-Z0-9\.\_\-]/) {
			throw Oak::Web::Additional::UsernameField::Error::InvalidUsername;
		}
		return 1;
	}
}

=head1 EXCEPTIONS

=over

=item Oak::Web::Additional::UsernameField::Error::InvalidUsername

An invalid date was found.

=back

=cut

package Oak::Web::Additional::UsernameField::Error::InvalidUsername;

use base qw (Error);

sub stringify {
	return "Invalid Username";
}

1;

__END__

=head1 COPYRIGHT

Copyright (c) 2001
Daniel Ruoso <daniel@ruoso.com>
All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
