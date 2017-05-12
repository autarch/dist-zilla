package Dist::Zilla::Plugin::MetaTests;
# ABSTRACT: common extra tests for META.yml

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::PrereqSource';

use Dist::Zilla::Dialect;

use namespace::autoclean;

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following files:

  xt/author/meta-yaml.t - a standard Test::CPAN::Meta test

L<Test::CPAN::Meta> will be added as a C<develop requires> dependency (which
can be installed via C<< dzil listdeps --author | cpanm >>).

=head1 SEE ALSO

Core Dist::Zilla plugins:
L<MetaResources|Dist::Zilla::Plugin::MetaResources>,
L<MetaNoIndex|Dist::Zilla::Plugin::MetaNoIndex>,
L<MetaYAML|Dist::Zilla::Plugin::MetaYAML>,
L<MetaJSON|Dist::Zilla::Plugin::MetaJSON>,
L<MetaConfig|Dist::Zilla::Plugin::MetaConfig>.

=cut

# Register the author test prereq as a "develop requires"
# so it will be listed in "dzil listdeps --author"
sub register_prereqs {
  my ($self) = @_;

  $self->zilla->register_prereqs(
    {
      phase => 'develop', type  => 'requires',
    },
    'Test::CPAN::Meta'     => 0,
  );
}

__PACKAGE__->meta->make_immutable;
1;

__DATA__
___[ xt/author/distmeta.t ]___
#!perl
# This file was automatically generated by Dist::Zilla::Plugin::MetaTests.

use Test::CPAN::Meta;

meta_yaml_ok();
