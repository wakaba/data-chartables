#!/usr/bin/perl
use strict;
use 5.7.3;

require Encode;
my %T;
my %option;
while (<>) {
if (/^0x([0-9A-F][0-9A-F][0-9A-F][0-9A-F])\tU\+([0-9A-F]+)\t/) {
  $T{ hex $1 } = hex $2;
} elsif (/^#\?o ([A-Za-z0-9-]+)="([^"]+)"/) {
  my $n = $1; $n =~ tr/-/_/; $option{$n} = $2;
}
}

require 'internal.pl';
$option{offset} ||= &internal::cp_start (%option) || $internal::cp_start{ $option{charset_name} || $option{table_name} };

my (@T, @U);
$option{_start} = $option{charset_chars} == 94 ? 0x21 : 0x20;
@U = sort { $a->[0] <=> $b->[0] }
     map { 
       [ (int ($_ / 0x100) - $option{_start}) * $option{charset_chars}
         + (($_ % 0x100) - $option{_start}) + $option{offset},
         $T{ $_ } ]
     } keys %T;

my $tbl = '';
my $pack = '';
for (@U) {
  for ($_->[0], $_->[1]) {
    $_ = chr $_; $_ = $_ eq "\\" ? "\\\\" : $_ eq q(') ? q(\') : $_;
    Encode::_utf8_off ($_);
    $tbl .= $_;
    $pack .= 'a' . length ($_);
  }
}

print <<EOH;
## This file is auto-generated (at @{[ sprintf '%04d-%02d-%02dT%02d:%02d:%02dZ', (gmtime)[5]+1900, (gmtime)[4]+1, (gmtime)[3,2,1,0] ]}).
## Do not edit by hand!

=head1 NAME

Encode::Table::$option{table_name} --- Convertion tables
used with Encode::Table, C<$option{table_name}_to_ucs>
and C<ucs_to_$option{table_name}>

=head1 TABLES

=over 4

=item $option{table_name}_to_ucs

Convertion table of $option{table_name} -> ucs

=item ucs_to_$option{table_name}

Convertion table of ucs -> $option{table_name}

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<$option{table_name}.tbr>.)

=cut

package Encode::Table::$option{table_name};
use strict;
use vars qw/%L2U %U2L/;

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

%L2U = map {Encode::_utf8_on (\$_); \$_} unpack (q{$pack}, <<'END');
EOH

print $tbl,"\nEND\n";

print <<EOH;
%U2L = reverse %L2U;
sub import {
  \$Encode::Table::TABLE{"$option{table_name}_to_ucs"} = \\%L2U;
  \$Encode::Table::TABLE{"ucs_to_$option{table_name}"} = \\%U2L;
}
1;
### $option{table_name} ends here
EOH

1; ## $Date: 2002/10/05 00:25:14 $
### tbl2pm.pl ends here
