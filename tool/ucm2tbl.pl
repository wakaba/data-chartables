#!/usr/bin/perl

=head1 NAME

ucm2tbl --- Mapping table converter, ucm to PETBL/1.0 format

=head1 USAGE

 $ perl ucm2tbl.pl cp932.ucm > cp932.tbl

=cut

use strict;
{
my @name = split /\n/, require 'unicore/Name.pl';
my %name;
for (@name) {
if (/^(....)		([^\t]+)/) {
  $name{hex $1} = $2;
}
}
sub charname ($) {
  my $U = shift;
  if ($U =~ /[^0-9]/) {
    $U =~ s/^[Uu]\+|^0[Xx]//;
    $U = hex $U;
  }
  ## TODO: be more strict!
  $U < 0x0020 ? '<control>' :
  $U < 0x007F ? $name{$U} :
  $U < 0x00A0 ? '<control>' :
  $name{$U} ? $name{$U} :
  $U < 0x00A0 ? '<control>' :
  $U < 0x3400 ? '' :
  $U < 0xA000 ? '<cjk>' :
  $U < 0xE000 ? '<hangul>' :
  $U < 0xF900 ? '<private>' :
  '';
}
}

print qq(#?PETBL/1.0\n);
my @char;
while (<>) {
  if (/^<U([0-9A-Fa-f]+)>\s+([0-9A-Fa-f\\Xx]+)\s+\|(\d)/) {
    my ($u, $c, $f) = (hex $1, $2, $3);
    $c =~ tr/\\Xx//d;  $c = hex $c;
    if ($c < 0x100) {
      push @char, sprintf q(0x%02X	U+%04X	%s	# %s%s), $c, $u, ['','<-','','->']->[$f], charname ($u), "\n";
    } else {
      push @char, sprintf q(0x%04X	U+%04X	%s	# %s%s), $c, $u, ['','<-','','->']->[$f], charname ($u), "\n";
    }
  } elsif (/^<code_set_name>\s+"([^"]+)"/) {
    print qq(#?o name="$1"\n);
  } elsif (/^<([^>]+)>\s+(.+)/) {
    my ($n,$v) = ($1,$2);  $v =~ s/([\\"])/\\$1/g;
    print qq(#?o ucm:$n="$v"\n);
  } elsif (s/^#\s?// && (tr/\x0A\x0D//d || 1)) {
    print qq(## $_\n);
  }
}
print sort @char;

=head1 AUTHOR

Nanashi-san (SuikaWiki:WindowsCodePage
<http://suika.fam.cx/~wakaba/-temp/wiki/wiki?WindowsCodePage>)

=head1 LICENSE

Public Domain.

=cut

# $Date: 2002/12/12 07:45:49 $
