package Oak::Web::Additional::TableList;

use strict;
use base qw(Oak::Web::Visual);

=head1 NAME

Oak::Web::Additional::TableList - Creates a list with a table (supporting a link with onclick)

=head1 HIERARCHY

L<Oak::Object|Oak::Object>

L<Oak::Persistent|Oak::Persistent>

L<Oak::Web::Visual|Oak::Web::Visual>

L<Oak::Web::Additional::TableList|Oak::Web::Additional::TableList>

=head1 DESCRIPTION

This component takes the array reference in the "data" property and creates a table where the
first line of the array indicates the name of the columns and the other lines are used as the
items itself.

=head1 PROPERTIES

=over

=item format

An text with the definitions for the colum:

  align="left" valign="middle" style="la"|align="right" valign="middle" style="la"

=item data

An array reference with the following structure:

  usuarios = [
	      [undef,columnname1,columnname2,columnname3]
	      [id1,item1value1,item1value2,item1value3,item1class],
	      [id2,item2value1,item2value2,item2value3],
	      [id3,item3value1,item3value2,item3value3,item3class],
	     ...
	     ]

When you specify more elements in a line then the declared columns, this additional element is
used as the class for the <TR> element of that item.

=item class

The css class applied to the TABLE element.

=item selected

The id of the selected item.

=item do_not_use_link

If this property is setted, no link is created

=item link_at

Set in wich column to set the link (default 1)

=item application

the target of the link

=item origin

the __owa_origin__ of the link (defaults to $self->{owner}->get('name'))

=back

=head1 EVENTS

=over

=item ev_onClick

Dispatched when one of the items in the table is selected.

=back

=cut

sub show {
	my $self = shift;
	$self->SUPER::show;
	$self->set(data => []) unless ref $self->get('data') eq "ARRAY";
	print "<TABLE";
	print " CLASS=\"".$self->get('class')."\"" if $self->get('class');
	print ">";
	$self->_show_headers;
	$self->_show_items;
	print "</TABLE>";
}

sub _show_headers {
	my $self = shift;
	print "<TR>";
	my $data = $self->get('data');
	$data->[0] = [] unless ref $data->[0] eq "ARRAY";
	my $i = 0;
	foreach my $column (@{$data->[0]}) {
		next unless $i++; # jump the first
		print "<TH>".$column."</TH>";
	}
	print "</TR>";
}

sub _show_items {
	my $self = shift;
	my $data = $self->get('data');
	$data->[0] = [] unless ref $data->[0] eq "ARRAY";
	my $numcolumns = scalar(@{$data->[0]});
	
	my @formatter = split(/\|/, $self->get("format"));
	my $index = 0;
	$self->set(link_at => 1) unless $self->get("link_at");
	foreach my $item (@{$data}) {
		if ($index == 0) {
			$index++;
			next;
		}
		$item = [] unless ref $item eq "ARRAY";
		print "<TR";
		if (scalar(@{$item}) > $numcolumns) {
			print " CLASS=\"".$item->[$numcolumns]."\"";
		}
		print ">";
		my $counter = 0;
		my $id = $item->[0];
		foreach my $value (@{$item}) {
			my $format = $formatter[$counter - 1];
			next unless $counter++;
			last if $counter > $numcolumns;	
			print "<TD";
			print " ".$format if $format;
			print ">";
			if ($self->get("do_not_use_link") || $counter != ($self->get("link_at")+1)) {
				print $value;
			} else {
				my $orig = $self->get('origin') || $self->{__owner__}->get('name');
				print "<A HREF=\"".$self->get('application')."?__owa_origin__=".$orig;
				print "\&".$self->get('name')."=".$id."\">".$value."</A>";
			}
			print "</TD>";
		}
		print "</TR>";
		$index++;
	}
}

sub receive_cgi {
	my $self = shift;
	my $cgi = shift;
	my $selected;
	if ($selected = $cgi->param($self->get('name'))) {
		$self->set(selected => $selected);
		$self->{__events__}{ev_onClick} = 1;
	}
}


1;


__END__

=head1 COPYRIGHT

Copyright (c) 2001
Daniel Ruoso <daniel@ruoso.com>
Carlos Eduardo de Andrade Brasileiro <eduardo@oktiva.com.br>
All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.


