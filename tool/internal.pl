=head1 NAME

internal.pl --- Utilities to get information of internal code
(to generate dumped script).

=head1 DESCRIPTION

This library collects functions and constants of internal
coding system properties.  Internal code allocation is
temporary so that (pre-dumped) source script should not
be embeded internal code related information (such as
code point of a character from ISO-IR) as far as possible.

=cut

package internal;
use strict;
use 5.7.3;

use vars qw/%cp_start/;

%cp_start = (
	jisx0208_1990	=> 0xE9F6C0 + 94*94*79,
);

sub cp_start (%) {
  my %o = @_;
  if ($o{charset_chars} == 94 && $o{charset_dimension} == 2
    && length $o{charset_final_byte}) {
    0xE9F6C0 + 94*94*(ord ($o{charset_final_byte})-0x30)
  } elsif ($o{charset_chars} == 94 && $o{charset_dimension} == 1
    && length $o{charset_final_byte}) {
    0xE90940 + 94*(ord ($o{charset_final_byte})-0x30)
  }
}

=head1 SEE ALSO

Encode::Table, Encode::ISO2022, tbl2pm.pl

=head1 AUTHOR

Nanashi-san

=head1 LICENSE

Copyright 2002 AUTHOR

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1; ## $Date: 2002/10/05 05:01:24 $
### internal.pl ends here
