#!/usr/bin/perl
use strict;

=head1 NEMA

esr2pm.pl --- Simple Encode module generator

=cut

my %ReplaceText = &ReplaceText;
my %Info;
my $mode = 0;
my $section = '';
my %item;
while (<>) {
  if ($mode == 1) {	## In a block
    if (/^\}$/) {
      $item{ModuleName} ||= $item{Name};
      $item{ModuleName} =~ s/[^0-9A-Za-z_]/_/g;
      push @{ $Info{encoding} }, {%item};
      $mode = 0;  %item = ();
    } elsif (/^(.+):$/) {
      $section = $1;
    } elsif (/^\t(.*)$/) {
      my $l = $1;
      if ($section =~ /^(?:En|De)code/ || $section == 'Cversion') {
        if ($l =~ /^->(.+):C$/) {
          my $name = $1;
          if ($name eq 'iso2022') {
            $l = q(($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C););
          } elsif ($name eq 'sjis') {
            $l = q($s = Encode::SJIS::internal_to_sjis ($s, $C););
          }
        } elsif ($l =~ /^->(.+)$/) {
          $l = qq(my \$e = Encode::find_encoding (q($1))->__clone;\n\$e->{_encode_mapping} = 0;\n\$s = \$e->encode (\$s););
          $Info{__use_clone} = 1;
        } elsif ($l =~ /^<-(.+):C$/) {
          my $name = $1;
          if ($name eq 'iso2022') {
            $l = q($s = Encode::ISO2022::iso2022_to_internal ($s, $C););
          } elsif ($name eq 'sjis') {
            $l = q($s = Encode::SJIS::sjis_to_internal ($s, $C););
          }
        } elsif ($l =~ /^<-(.+)$/) {
          $l = qq(my \$e = Encode::find_encoding (q($1))->__clone;\n\$e->{_decode_mapping} = 0;\n\$s = \$e->decode (\$s););
        } elsif ($l =~ /^(?:<=|=>)(.+)$/) {
          $l = qq(\$s = Encode::Table::convert (\$s, [qw($1)], \%tblopt) if \$tbl;);
        } elsif ($l =~ /^utf8:o(n|ff)$/) {
          $l = qq(Encode::_utf8_o$1 (\$s););
        } elsif ($l =~ /^C:([GC][^=:]+)=([^:]+):([^\t]+)(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{$1} = \$Encode::Charset::CHARSET{$2}->{'$3'};$4);
        } elsif ($l =~ /^C:option:([^=]+)=([^\t]+?)(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{option}->$1 = $2;$3);
        } elsif ($l =~ /^C:designate:\*:default=(-?[0-3]+)$/) {
          $l = qq(\$C->{option}->{designate_to}->{G94}->{default} = $1;\n).
               qq(\$C->{option}->{designate_to}->{G96}->{default} = $1;\n).
               qq(\$C->{option}->{designate_to}->{G94n}->{default} = $1;\n).
               qq(\$C->{option}->{designate_to}->{G96n}->{default} = $1;\n).
               qq(\$C->{option}->{designate_to}->{C0}->{default} = $1;\n).
               qq(\$C->{option}->{designate_to}->{C1}->{default} = $1;);
        } elsif ($l =~ /^C:designate:\*drcs:default=(-?[0-3]+)$/) {
          $l = qq(for (0x30..0x7E) {\n).
               qq(my \$F = chr \$_;\n).
               qq(  \$C->{option}->{designate_to}->{G94}->{\$F} = $1;\n).
               qq(  \$C->{option}->{designate_to}->{G96}->{\$F} = $1;\n).
               qq(  \$C->{option}->{designate_to}->{G94n}->{\$F} = $1;\n).
               qq(  \$C->{option}->{designate_to}->{G96n}->{\$F} = $1;\n).
               qq(});
        } elsif ($l =~ /^C:designate:\*private:default=(-?[0-3]+)$/) {
          $l = qq(for (0x30..0x3F) {\n).
               qq(  my \$F = chr \$_;\n).
               qq(  for my \$c (qw/G94 G96 G94n G96n C0 C1/) {\n).
               qq(    \$C->{option}->{designate_to}->{\$c}->{\$F} = $1;\n).
               qq(    \$C->{option}->{designate_to}->{\$c}->{'\x21'.\$F} = $1;\n).
               qq(    \$C->{option}->{designate_to}->{\$c}->{'\x22'.\$F} = $1;\n).
               qq(    \$C->{option}->{designate_to}->{\$c}->{'\x23'.\$F} = $1;\n).
               qq(  }\n);
               qq(});
        } elsif ($l =~ /^C:designate:([^:=]+):([^=]+)=(-?[0-3]+)(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{option}->{designate_to}->{$1}->{'$2'} = $3;$4);
        } elsif ($l =~ /^C:([GC][LR])=undef(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{$1} = undef;$3);
        } elsif ($l =~ /^C:([GC][LR])=(..)(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{$1} = '$2';$3);
        } elsif ($l =~ /^C:bit=([78])(\t\s*\#\#.+)?$/) {
          $l = qq(\$C->{bit} = $1;$2);
        } elsif ($l =~ /^use:table:(.+)$/) {
          $l = qq(eval q(use Encode::Table::$1) unless \$Encode::Table::$1::VERSION;);
        } elsif ($l =~ /^require:private:(.+)$/) {
          $l = qq(eval q(use Encode::Charset::Private q(:$1)) or die \$\@;);
        } elsif ($l =~ /^use:private:(.+)$/) {
          $l = qq(eval q(use Encode::Charset::Private q(:$1)) or die \$\@;\neval q(Encode::Charset::Private::designate_$1 (\$C)););
        } elsif ($l =~ /^use:(.+)$/) {
          $l = qq(eval q(use $1) unless \$$1::VERSION;);
        } elsif ($l =~ /^\#;/) {
          $l = undef;
        }
      }
      if ($item{$section}) {
        $item{$section} .= "\n".$l if defined $l;
      } else {
        $item{$section} = $l;
      }
    }
  } else {	## Out of blocks
    if (/^\{$/) {
      $mode = 1;
    } elsif (/^(.+):$/) {
      $section = $1;
    } elsif (/^\t(.*)$/) {
      my $t = $1;
      if ($Info{$section}) {
        $Info{$section} .= "\n".$t;
      } else {
        $Info{$section} = $t;
      }
    }
  }
}
$ReplaceText{MYSELF} = qq(Encode::$Info{Name});

print <<EOH;
## This file is auto-generated (at @{[ sprintf '%04d-%02d-%02dT%02d:%02d:%02dZ', (gmtime)[5]+1900, (gmtime)[4]+1, (gmtime)[3,2,1,0] ]}).
## Do not edit by hand!

=head1 NAME

$ReplaceText{MYSELF} --- $Info{ShortDescription}
@{[ $Info{'POD:DESCRIPTION'} ? qq{
=head1 DESCRIPTION

$Info{'POD:DESCRIPTION'}} : '']}

=cut

package $ReplaceText{MYSELF};
use 5.7.3;
use strict;
our \$VERSION = q(@{[sprintf '%04d.%02d%02d', (gmtime)[5]+1900, (gmtime)[4]+1, (gmtime)[3]]});

=head1 ENCODINGS
@{[ $Info{'POD:ENCODING:PREAMBLE'} ? qq(
$Info{'POD:ENCODING:PREAMBLE'}
) : '']}
=over 8

=cut

EOH

for my $encode (@{ $Info{encoding} }) {
  $encode->{EncodeFull} = $encode->{'Encode:Prepare'}."\n".$encode->{Encode};
  $encode->{DecodeFull} = $encode->{'Decode:Prepare'}."\n".$encode->{Decode};
  for my $ED (qw/Encode Decode EncodeFull DecodeFull Cversion/) {
    my $ed = $ED =~ /Encode/ ? 'encode' : 'decode';
    if ($encode->{$ED} =~ /Encode::Table/) {
      $encode->{$ED} = q/require Encode::Table;
my $tbl = defined $obj->{_/.$ed.q/_mapping} ? $obj->{_/.$ed.q/_mapping} : 1;
my %tblopt = (-autoload => defined $obj->{_/.$ed.q/_mapping_autoload} ? $obj->{_/.$ed.q/_mapping_autoload} : 1);
/.$encode->{$ED};
    }
    if ($encode->{$ED} =~ /\$C/) {
      if ($ED ne 'Cversion' && $encode->{Cversion}) {
        $encode->{$ED} = ($ED =~ /Full/ ? qq(my \$C = \$obj->__code_version;\n) : '')
                        .qq(\$C->{_encoder} = \$obj;\n)
                        .($ED eq 'EncodeFull' ? qq(\$C->{option}->{fallback_from_ucs} = \$obj->{_encode_fallback} ? \$obj->{_encode_fallback} :
  \$chk & Encode::DIE_ON_ERR ? 'croak' :
  \$chk & Encode::FB_WARN ? 'quiet+warn' : \$chk & Encode::RETURN_ON_ERR ? 'quiet' :
  \$chk & Encode::PERLQQ ? 'perl' :        \$chk & Encode::HTMLCREF ? 'sgml' :
  \$chk & Encode::XMLCREF ? 'sgml-hex' : 'replacement';
) : '')
                        .$encode->{$ED};
      } elsif ($encode->{$ED} =~ /SJIS/i) {
        $encode->{$ED} = qq(require Encode::Charset;\nmy \$C = &Encode::Charset::new_object_sjis;\n).$encode->{$ED};
      } else {
        $encode->{$ED} = qq(require Encode::Charset;\nmy \$C = &Encode::Charset::new_object;\n).$encode->{$ED};
      }
    }
    for (qw/ISO2022 SJIS/) {
      if ($encode->{$ED} =~ /Encode::$_/) {
        $encode->{$ED} = qq(require Encode::$_;\n).$encode->{$ED};
      }
    }
    $encode->{$ED} =~ s/\n/\n  /g;
  }
  print <<EOH;

package Encode::$Info{Name}::$encode->{ModuleName};
our \$VERSION = \$Encode::$Info{Name}::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/$encode->{Name} $encode->{Alias}/);

=item $encode->{Name}

$encode->{Description}@{[ $encode->{Alias} ? '
(Alias: ' . join (', ', split /\s+/, $encode->{Alias}) . ')' : '' ]}

=cut

sub encode (\$\$;\$) {
  my (\$obj, \$s, \$chk) = \@_;
  my \%s;
  $encode->{EncodeFull}
  if (\$s{die}) {	## FB_CROAK
    if (\$Carp::VERSION) { Carp::croak ('encode: '.\$s{reason}) }
    else { die ('encode: '.\$s{reason}) }
  } elsif (\$s{halfway}) {	## FB_QUIET, FB_WARNING
    \$_[1] = substr (\$_[1], \$s{converted_length});
    if (\$s{warn}) {
      if (\$Carp::VERSION) { Carp::carp ('encode: '.\$s{reason}) }
      else { warn ('encode: '.\$s{reason}) }
    }
  } else {
    \$_[1] = '' if \$chk;
  }
  return \$s;
}

sub _encode_internal (\$\$\$) {
  my (\$obj, \$s, \$C) = \@_;
  my \%s;
  $encode->{Encode}
  if (\$s{die}) {
    if (\$Carp::VERSION) { Carp::croak ('encode: '.\$s{reason}) }
    else { die ('encode: '.\$s{reason}) }
  }
  return \$s;
}

sub decode (\$\$;\$) {
  my (\$obj, \$s, \$chk) = \@_;
  $encode->{DecodeFull}
  \$_[1] = '' if \$chk;
  return \$s;
}
@{[ $encode->{Cversion} ? qq(
sub __code_version (\$) {
  $encode->{Cversion}
  \$C;
}):'']}
EOH
}

print <<EOH;

=back
@{[ $Info{'POD:ENCODING:POSTAMBLE'} ? qq(
$Info{'POD:ENCODING:POSTAMBLE'}
) : '']}
=cut
@{[$Info{__use_clone} ? q(
sub Encode::Encoding::__clone ($) {
  my $self = shift;
  bless {%$self}, ref $self;
}):'']}

EOH

for my $name (qw/EXAMPLE/, 'SEE ALSO', 'TO DO', qw/AUTHORS LICENSE/) {
  if ($Info{qq(POD:$name)}) {
    $Info{qq(POD:$name)} =~ s/%%([A-Za-z0-9_]+)%%/$ReplaceText{$1}/g;
    print <<EOH;
=head1 $name

$Info{qq(POD:$name)}

EOH
  }
}

print <<EOH;
=cut

1;
EOH

sub ReplaceText () {
  my %RT = (
    GNUGPL2	=> q{This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.},
    PerlLicense	=> q{This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.},
    ReferenceIANAREG => q([IANAREG] "CHARACTER SETS", IANA <http://www.iana.org/>,
<http://www.iana.org/assignments/character-sets>.
The charset registry for IETF <http://www.ietf.org/> standards.),
    ReferenceJISX0208_1978 => q(JIS C 6226 (JIS X 0208)-1978, "Code of Japanese graphic
character set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1978.),
    ReferenceJISX0208_1983 => q(JIS C 6226 (JIS X 0208)-1983, "Code of Japanese graphic
character set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1983.),
    ReferenceJISX0208_1990 => q(JIS X 0208-1990, "Code of Japanese graphic character
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1990.),
    ReferenceJISX0212_1990 => q(JIS X 0212-1990, "Code of supplementary Japanese graphic
character set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1990.),
    ReferenceJISX0221_1995 => q(JIS X 0221-1995, "Universal multi-octet coded character
set (UCS)", Japan Industrial Standards Committee
<http://www.jisc.go.jp/>, 1995.  IDT with ISO/IEC 10646-1:1993
but three additional appendixes.),
    ReferenceJISX0201_1997 => q(JIS X 0201:1997, "7-bit and 8-bit coded character
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.),
    ReferenceJISX0208_1997 => q(JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.),
    ReferenceJISX0213_2000 => q(JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.),
    ReferenceRFC1468 => q(RFC 1468, "Japanese Character Encoding for Internet Messages",
J. Murai, et al, IETF <http://www.ietf.org/>, June 1993.
<urn:ietf:rfc:1468>.),
    YEAR => (gmtime)[5]+1900,
  );
  %RT;
}

=head1 SEE ALSO

L<Encode>, L<Encode::Table>,
SuikaWiki:esr2pm <http://suika.fam.cx/~wakaba/-temp/wiki/wiki?esr2pm>

=head1 LICENSE

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

Note that modules generated by this script should be
licensed by the licenser of source file so that copyright
holder of this script does not claim any right to them.

=cut

# $Date: 2002/12/14 11:02:25 $
