package Oak::Web::Additional::DerivedPage;

use Error qw(:try);
use base qw(Oak::Web::TopLevel);

=head1 NAME

DerivedPage - Page that is derivated from another toplevel page

=head1 SYNOPSIS

MISSING DOCUMENTATION!!!!

Set the property parentPage of this component to the name of an existing
toplevel page. And the parent, top and left properties to the component
inside this page which will be the parent for the components.

=cut


sub show {
	my $self = shift;
	my %bag = @_;
	if (%bag) {
		$self->{BAG} = \%bag;
	}
	my $name = $self->get("parentPage");
	my $comp_name = $self->get("parent");
	my $object;
	if ($name && $::APPLICATION && !$self->{__owner__}) {
		# adds the reference between me and my parent
		$::APPLICATION->initiateTopLevel($name);
		eval '$object = $::TL::'.$name;
		$object->register_child($self);
		# show my parent
		$object->show(%bag);
		# remove the reference
		$object->free_child($self->get("name"));
	} else {
		# show itself (used when the owner is calling my show!!!
		# recursive magic!!! and dangerous tricks...
		my $old = $self->{__owner__};
		$self->{__owner__} = undef;
		$self->SUPER::show(%bag);
		$self->{__owner__} = $old;
	}

}

1;
