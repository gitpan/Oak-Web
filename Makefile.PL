use ExtUtils::MakeMaker;

my $mm = new MM
 (
  {
   AUTHOR => "Daniel Ruoso <daniel\@ruoso.com>",
   ABSTRACT => "Perl Oak Component Tree",
   NAME => "Oak::Web",
   VERSION => "1.7",
   PREREQ_PM => 
   {
    'Oak::Component'   => '0',
    'Oak::Object' => '0',
    'Time::Local' => '0',
    'CGI' => '0',
    'CGI::Cookie' => '0',
   }
  }
 );

$mm->flush;
