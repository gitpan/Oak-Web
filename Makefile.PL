use ExtUtils::MakeMaker;

my $mm = new MM
 (
  {
   AUTHOR => "Daniel Ruoso <daniel\@ruoso.com>",
   ABSTRACT => "Perl Oak Component Tree - Web modules",
   NAME => "Oak::Web",
   PMLIBDIRS => ['Additional','HTML'],
   VERSION => "1.3",
   PREREQ_PM   =>
   {
    'Oak::Object' => '0',
    'CGI' => '0'
   }
  }
 );

$mm->flush;

# I had to overwrite this function, because this
# is a package and not just a module.

sub MM::init_main {
	package MM; # so that "SUPER" works right
	my $self = shift;
	my $return = $self->SUPER::init_main();
	$self->{NAME}="Oak::Web";
	$self->{PARENT_NAME}="Oak::Web";
	$self->{BASEEXT}="";
	return $return;
}


