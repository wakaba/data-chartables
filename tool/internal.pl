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
  }
}

1; ## $Date: 2002/10/05 00:25:14 $
### internal.pl ends here
