#!/usr/bin/perl

=head1 NAME

typo2tbl --- Mapping table converter, Microsoft typography's table
to our tbl format

=head1 USAGE

 $ perl typo2tbl.pl 932.txt > ms932.tbl

=cut

use v5.8.0;
use strict;
my %add_hdr = (
	932 => q(# ucm:code_set_alias	Windows-31J	Windows31J	csWindows31J	SJIS-CP932	MS932	X-MS-CP932	mscode	X-SJIS-CP932	sjis-ms),
);

my %U2C;
my %C2U;
my @hdr;
my $u = 0;
my $Umode = 0;
while (<>) {
  if ($Umode) {
    if (/0x(\S+)	0x(\S+)/) {
      $U2C{ hex $1 } = hex $2;
    }
  } elsif (/0x\S+	0x\S+	;Lead Byte Range/) {
  } elsif (/0x(\S+)	0x(\S+)/) {
    $C2U{ $u + hex $1 } = hex $2;
  } elsif (/DBCSTABLE.+?;LeadByte = 0x(\S+)/) {
    $u = 0x100 * hex $1;
  } elsif (/WCTABLE/) {
    $Umode = 1;
  } elsif (/^CODEPAGE (\d+)/) {
    push @hdr, qq(# name	ms$1);
    push @hdr, $add_hdr{$1};
  } elsif (/^CPINFO (\d) (0x\S+) (0x\S+)/) {
    push @hdr, qq(# ucm:mb_cur_max	$1);
    push @hdr, qq(# <-ucs-substition	$2);
    push @hdr, qq(# ->ucs-substition	$3);
  }
}

{
my @name = split /\n/, require 'unicore/Name.pl';
my %name;
for (@name) {
if (/^(....)		([^\t]+)/) {
  $name{hex $1} = $2;
}
}
sub NAME ($) {
  $_[0] < 0x0020 ? '<control>' :
  $_[0] < 0x007F ? $name{$_[0]} :
  $_[0] < 0x00A0 ? '<control>' :
  $name{$_[0]} ? $name{$_[0]} :
  $_[0] < 0x00A0 ? '<control>' :
  $_[0] < 0x3400 ? '' :
  $_[0] < 0xA000 ? '<cjk>' :
  $_[0] < 0xE000 ? '<hangul>' :
  $_[0] < 0xF900 ? '<private>' :
  '';
}
}

my @t;
for my $U (keys %U2C) {
    if ($C2U{$U2C{$U}} == $U) {
      push @t, sprintf '0x%04X	U+%04X		# %s',
                       $U2C{$U}, $U, NAME ($U);
      delete $C2U{ $U2C{$U} };
    } else {
      push @t, sprintf '0x%04X	U+%04X	<-	# %s',
                       $U2C{$U}, $U, NAME ($U);
    }
}
for my $C (keys %C2U) {
  push @t, sprintf '0x%04X	U+%04X	->	# %s',
                       $C, $C2U{$C}, NAME ($C2U{$C});
}

for (@t) {
  s/^0x00(..)/0x$1/;
}

print "#; This file is auto-generated (at @{[ sprintf '%04d-%02d-%02dT%02d:%02d:%02dZ', (gmtime)[5]+1900, (gmtime)[4]+1, (gmtime)[3,2,1,0] ]}).\n#; Do not edit by hand!\n";
print join "\n", @hdr, sort @t;
print "\n";

=head1 SEE ALSO

Character sets and codepages (Microsoft typography)
<http://www.microsoft.com/typography/unicode/cscp.htm> 

=head1 AUTHOR

Nanashi-san (SuikaWiki:WindowsCodePage
<http://suika.fam.cx/~wakaba/-temp/wiki/wiki?WindowsCodePage>)

=head1 LICENSE

Public Domain.

=cut

# $Date: 2002/12/12 07:45:49 $
