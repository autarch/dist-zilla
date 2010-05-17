package Dist::Zilla::Plugin::MetaJSON;
# ABSTRACT: produce a META.json
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FileGatherer';

use CPAN::Meta::Converter 2.101370; # downgrade
use Dist::Zilla::File::FromCode;
use Hash::Merge::Simple ();
use JSON 2;

=head1 DESCRIPTION

This plugin will add a F<META.json> file to the distribution.

This file is meant to replace the old-style F<META.yml>.  For more information
on this file, see L<Module::Build::API> and
L<http://module-build.sourceforge.net/META-spec-v1.3.html>.

=cut

has filename => (
  is  => 'ro',
  isa => 'Str',
  default => 'META.json',
);

has version => (
  is  => 'ro',
  isa => 'Num',
  default => '1.4',
);

sub gather_files {
  my ($self, $arg) = @_;

  my $zilla = $self->zilla;

  my $distmeta  = $zilla->distmeta;
  my $converter = CPAN::Meta::Converter->new($distmeta);
  my $output    = $converter->convert(version => $self->version);

  my $file  = Dist::Zilla::File::FromCode->new({
    name => $self->filename,
    code => sub {
      JSON->new->ascii(1)->canonical(1)->pretty->encode($output)
      . "\n";
    },
  });

  $self->add_file($file);
  return;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
