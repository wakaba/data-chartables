
PLDIR = tool/
PERL = perl
PERLI = $(PERL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl

TBL_jis = jisx0208_1978.tbl jisx0208_1978_irv.tbl \
  jisx0208_1983.tbl jisx0208_1983_irv.tbl jisx0208_1990.tbl \
  jisx0208_1990_open_0201.tbl jisx0208_1990_open_ascii.tbl \
  jisx0208_1997.tbl jisx0208_1997_irv.tbl jisx0208_1997_latin.tbl jisx0208_1997_yen.tbl \
  jisx0212_1990.tbl jisx0212_1990_irv.tbl jisx0212_0213.tbl \
  jisx0212_1990_open_0201.tbl jisx0212_1990_open_ascii.tbl \
  jisx0212_1990_open_ms.tbl \
  jisx0213_2000_1.tbl jisx0213_2000_1_esc_24_42.tbl jisx0213_2000_2.tbl \
  jisx0201_latin.tbl jisx0201_katakana.tbl ascii_yen.tbl \
  jisx0208_to_katakana_hw.tbl
TBL_gb = gb2312_1980.tbl gb12345_1990.tbl iso_ir_165.tbl
TBL_ks = ksx1001_1992.tbl
TBL_kps = kps9566_1997.tbl
TBL_photograph = imode.tbl lmode.tbl doti.tbl jphone.tbl iso_ir_169.tbl
TBL_misc = iso_ir_231.tbl
TBL_iso8859 = isoiec8859_2.tbl isoiec8859_3.tbl isoiec8859_4.tbl \
  isoiec8859_5.tbl isoiec8859_6.tbl isoiec8859_7.tbl \
  isoiec8859_8.tbl isoiec8859_8_1999.tbl isoiec8859_9.tbl \
  isoiec8859_10.tbl #isoiec8859_11.tbl \
  isoiec8859_13.tbl \
  isoiec8859_14.tbl isoiec8859_15.tbl isoiec8859_16.tbl \
  iso_ir_204.tbl iso_ir_205.tbl iso_ir_206.tbl

all: jis gb ks kps iso8859 photograph misc

jis:  $(TBL_jis)
jis-tbl:  $(TBL_jis)
gb:  $(TBL_gb)
gb-tbl:  $(TBL_gb)
ks:  $(TBL_ks)
ks-tbl:  $(TBL_ks)
kps:  $(TBL_kps)
kps-tbl:  $(TBL_kps)
iso8859:  $(TBL_iso8859)
iso8859-tbl:  $(TBL_iso8859)
photograph:  $(TBL_photograph)
photograph-tbl:  $(TBL_photograph)
misc:  $(TBL_misc)
misc-tbl:  $(TBL_misc)

%.tbl: %.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

euc_jp_open_ascii.tbl: euc_jp_open_ascii.tbr $(TBR2TBL) \
  jisx0208_1990_open_ascii.tbl \
  jisx0212_1990_open_ascii.tbl
	$(PERLI) $(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~
	rm -ffv $(TBL_jis) $(TBL_jis) \
	  $(TBL_gb) $(TBL_gb) \
	  $(TBL_ks) $(TBL_ks) \
	  $(TBL_kps) $(TBL_kps) \
	  $(TBL_iso8859) $(TBL_iso8859) \
	  $(TBL_misc) $(TBL_misc)
	  $(TBL_photograph) $(TBL_photograph)

## License: Public Domain.
