
PLDIR = tool/
PERL = perl
PERLI = $(PERL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl
TBL2PM = $(PLDIR)tbl2pm.pl

PM_jis = jisx0208_1978.pm jisx0208_1978_irv.pm \
  jisx0208_1983.pm jisx0208_1983_irv.pm jisx0208_1990.pm \
  jisx0208_1990_open_0201.pm jisx0208_1990_open_ascii.pm \
  jisx0208_1997.pm jisx0208_1997_irv.pm jisx0208_1997_latin.pm jisx0208_1997_yen.pm \
  jisx0212_1990.pm jisx0212_1990_irv.pm jisx0212_0213.pm \
  jisx0212_1990_open_0201.pm jisx0212_1990_open_ascii.pm \
  jisx0212_1990_open_ms.pm \
  jisx0213_2000_1.pm jisx0213_2000_1_esc_24_42.pm jisx0213_2000_2.pm \
  jisx0201_latin.pm jisx0201_katakana.pm ascii_yen.pm \
  jisx0208_to_katakana.pm
PM_gb = gb2312_1980.pm gb12345_1990.pm iso_ir_165.pm
PM_ks = ksx1001_1992.pm
PM_kps = kps9566_1997.pm
PM_photograph = imode.pm lmode.pm doti.pm jphone.pm iso_ir_169.pm
PM_misc = iso_ir_231.pm
PM_iso8859 = isoiec8859_2.pm isoiec8859_3.pm isoiec8859_4.pm \
  isoiec8859_5.pm isoiec8859_6.pm isoiec8859_7.pm \
  isoiec8859_8.pm isoiec8859_8_1999.pm isoiec8859_9.pm \
  isoiec8859_10.pm isoiec8859_11.pm isoiec8859_13.pm \
  isoiec8859_14.pm isoiec8859_15.pm isoiec8859_16.pm \
  iso_ir_204.pm iso_ir_205.pm iso_ir_206.pm

all: jis gb ks kps iso8859 photograph misc

jis:  $(PM_jis)
jis-tbl:  $(PM_jis:.pm=.tbl)
gb:  $(PM_gb)
gb-tbl:  $(PM_gb:.pm=.tbl)
ks:  $(PM_ks)
ks-tbl:  $(PM_ks:.pm=.tbl)
kps:  $(PM_kps)
kps-tbl:  $(PM_kps:.pm=.tbl)
iso8859:  $(PM_iso8859)
iso8859-tbl:  $(PM_iso8859:.pm=.tbl)
photograph:  $(PM_photograph)
photograph-tbl:  $(PM_photograph:.pm=.tbl)
misc:  $(PM_misc)
misc-tbl:  $(PM_misc:.pm=.tbl)

%.tbl: %.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

%.pm: %.tbl $(TBL2PM) $(PLDIR)internal.pl
	$(PERLI) $(TBL2PM) $< > $@
	$(PERLI) -c $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~
	rm -ffv $(PM_jis) $(PM_jis:.pm=.tbl) \
	  $(PM_gb) $(PM_gb:.pm=.tbl) \
	  $(PM_ks) $(PM_ks:.pm=.tbl) \
	  $(PM_kps) $(PM_kps:.pm=.tbl) \
	  $(PM_iso8859) $(PM_iso8859:.pm=.tbl) \
	  $(PM_misc) $(PM_misc:.pm=.tbl)
	  $(PM_photograph) $(PM_photograph:.pm=.tbl)
