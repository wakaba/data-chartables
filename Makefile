
PLDIR = tool/
PERL = perl
PERLI = $(PERL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl
TBL2PM = $(PLDIR)tbl2pm.pl

PM_jis = jisx0208_1978.pm jisx0208_1983.pm jisx0208_1990.pm \
  jisx0208_1997.pm jisx0208_1997_irv.pm jisx0208_1997_latin.pm \
  jisx0212_1990.pm jisx0212_1990_irv.pm jisx0212_0213.pm \
  jisx0213_2000_1.pm jisx0213_2000_1_esc_24_42.pm jisx0213_2000_2.pm \
  jisx0201_latin.pm jisx0201_katakana.pm

jis:  $(PM_jis)
jis-tbl:  $(PM_jis:.pm=.tbl)

%.tbl: %.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

%.pm: %.tbl $(TBL2PM) $(PLDIR)internal.pl
	$(PERLI) $(TBL2PM) $< > $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~
	rm -ffv $(PM_jis) $(PM_jis:.pm=.tbl)
