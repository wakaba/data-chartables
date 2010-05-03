#!/usr/bin/perl
use strict;
use Path::Class;

=head1 NAME

tbr2tbl --- PETBL/1.0 source(s) to completed table converter

=cut

my %CMD;
my %C;
$C{tbl_std_cl} = [split /\n/, <<EOH];
0x00	U+0000		# <control>
0x01	U+0001		# <control>
0x02	U+0002		# <control>
0x03	U+0003		# <control>
0x04	U+0004		# <control>
0x05	U+0005		# <control>
0x06	U+0006		# <control>
0x07	U+0007		# <control>
0x08	U+0008		# <control>
0x09	U+0009		# <control>
0x0A	U+000A		# <control>
0x0B	U+000B		# <control>
0x0C	U+000C		# <control>
0x0D	U+000D		# <control>
0x0E	U+000E		# <control>
0x0F	U+000F		# <control>
0x10	U+0010		# <control>
0x11	U+0011		# <control>
0x12	U+0012		# <control>
0x13	U+0013		# <control>
0x14	U+0014		# <control>
0x15	U+0015		# <control>
0x16	U+0016		# <control>
0x17	U+0017		# <control>
0x18	U+0018		# <control>
0x19	U+0019		# <control>
0x1A	U+001A		# <control>
0x1B	U+001B		# <control>
0x1C	U+001C		# <control>
0x1D	U+001D		# <control>
0x1E	U+001E		# <control>
0x1F	U+001F		# <control>
EOH
$C{tbl_std_20} = q(0x20	U+0020		# SPACE);
$C{tbl_std_7f} = q(0x7F	U+007F		# DELETE);
$C{tbl_std_cr} = [split /\n/, <<EOH];
0x80	U+0080		# <control>
0x81	U+0081		# <control>
0x82	U+0082		# <control>
0x83	U+0083		# <control>
0x84	U+0084		# <control>
0x85	U+0085		# <control>
0x86	U+0086		# <control>
0x87	U+0087		# <control>
0x88	U+0088		# <control>
0x89	U+0089		# <control>
0x8A	U+008A		# <control>
0x8B	U+008B		# <control>
0x8C	U+008C		# <control>
0x8D	U+008D		# <control>
0x8E	U+008E		# <control>
0x8F	U+008F		# <control>
0x90	U+0090		# <control>
0x91	U+0091		# <control>
0x92	U+0092		# <control>
0x93	U+0093		# <control>
0x94	U+0094		# <control>
0x95	U+0095		# <control>
0x96	U+0096		# <control>
0x97	U+0097		# <control>
0x98	U+0098		# <control>
0x99	U+0099		# <control>
0x9A	U+009A		# <control>
0x9B	U+009B		# <control>
0x9C	U+009C		# <control>
0x9D	U+009D		# <control>
0x9E	U+009E		# <control>
0x9F	U+009F		# <control>
EOH
$C{tbl_std_a0} = q(0xA0			# <reserved>);
$C{tbl_std_ff} = q(0xFF			# <reserved>);

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

sub array_to_table (@%) {
  my ($source, $o) = @_;
  my @r;  $o->{mode}->{DEFAULT} = 1;
  my $mode = 'DEFAULT';
  for (@$source) {
    if (/^#\?if-mode ([A-Za-z0-9-]+)/) {
      $mode = $1;
    } elsif (/^#\?end-if-mode/) {
      $mode = 'DEFAULT';
    } elsif ($o->{mode}->{$mode}) {	## mode is enabled
    
    if (/^#\?o/) {	## table option
      push @r, $_ unless $o->{_imported_file};
    } elsif (s/^#\?([A-Za-z0-9-]+)//) {
      my %opt = (cmd => $1);
      s{ ([A-Za-z0-9-]+)=(?:"((?:[^"\\]|\\.)*)"|([A-Za-z0-9-]+)) 
       | ([A-Za-z0-9-]+)}{
        my ($N, $V, $v, $n) = ($1, $2, $3, $4);
        $V =~ s/\\(.)/$1/g;
        $opt{ $N || $n } = $n ? 1 : ($V || $v);
      }gex;
      push @r, &{ $CMD{ $opt{cmd} } } ($o, \%opt) if ref $CMD{ $opt{cmd} };
    } elsif (/^##/) {	## Comment
      push @r, $_;
    } elsif (/^#;/) {	## Comment
    } elsif (/^#/) {	## Comment or unsupported function
      push @r, $_;
    } elsif (/^(0x|[0-9A-Za-z]+[+-])($o->{except} [0-9A-Fa-f]+)(?:\t([^\t]*)(?:\t([^\t]*)(?:\t(.*))?)?)?/x) {
      my ($p, $u, $l, $f, $m) = ($1, hex $2, $3, $4, $5);
      $f = $o->{fallback} if $o->{fallback};
      my $offset = $o->{offset};
      $offset += $u + $offset > 0xFF ? 0x8080 : 0x80 if $o->{right};
      $m =~ s/^#\s*//;
      push @r, sprintf qq{%s%02X\t%s\t%s\t# %s},
        $p, $u+$offset, $l, $f,
        #$m ||
        charname ($l);
    } elsif (/^$/) {
    } else {
      #push @r, $_;
    }
    
    }	# / mode is enabled
  }
  @r;
}

my $input_f;

$CMD{import} = sub {
  my ($opt0, $opt) = @_;
  if ($opt->{src}) {
    $input_f ||= file ($ARGV);
    my $included_f = $input_f->dir->file ($opt->{src});
    open TBL, '<', $included_f->stringify
        or die "$0: $included_f: Imported table not found";
    my @tbl = <TBL>;  close TBL;  map {s/[\x0D\x0A]+$//} @tbl;
    my $m = {}; for (split /,/, $opt->{mode}) { $m->{$_} = 1 }
    shift (@tbl) if $tbl[0] =~ m!^#\?PETBL/1.0 SOURCE!;
    $opt->{except} = $opt->{except} ? qq((?!(?i)$opt->{except})) : '';
    $opt->{except} .= $opt0->{except} if $opt0->{except};
    array_to_table (\@tbl, {offset => hex $opt->{offset},
      fallback => $opt->{fallback}, mode => $m,
      except => $opt->{except}, right => $opt->{right},
      _imported_file => 1});
  } elsif ($opt->{'std-cl'}) { @{ $C{tbl_std_cl} };
  } elsif ($opt->{'std-cr'}) { @{ $C{tbl_std_cr} };
  } elsif ($opt->{'std-0x20'} || $opt->{'std-sp'}) { $C{tbl_std_20};
  } elsif ($opt->{'std-0x7F'} || $opt->{'std-del'}) { $C{tbl_std_7f};
  } elsif ($opt->{'std-0xA0'}) { $C{tbl_std_a0};
  } elsif ($opt->{'std-0xFF'}) { $C{tbl_std_ff};
  }
};

my @src;
while (<>) {
  s/[\x0D\x0A]+$//;
  push @src, $_;
}
shift (@src) if $src[0] =~ m!^#\?PETBL/1.0 SOURCE!;
@src = sort {
$a =~ /^#/ ? 0 :
$b =~ /^#/ ? 0 : $a cmp $b
} array_to_table (\@src);

binmode STDOUT;
print "#?PETBL/1.0\n";
print join ("\n", @src)."\n";

=head1 LICENSE

Copyright 2002 Nanashi-san.

Copyright 2008-2010 Wakaba <w@suika.fam.cx>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

For clarification, the authors of this script hereby abstain any
intellectual property right on the data generated by this script.

=cut

1;
