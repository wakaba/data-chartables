
PLDIR = tool/
PERL = perl
PERLI = $(PRRL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl
TBL2PM = $(PLDIR)tbl2pm.pl

%.tbl: %.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

%.pm: %.tbl $(TBL2PM) $(PLDIR)internal.pl
	$(PERLI) $(TBL2PM) $< > $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~
