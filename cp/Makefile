
PLDIR = ../tool/
PERL = perl
PERLI = $(PERL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl
TBL2PM = $(PLDIR)tbl2pm.pl

TBL_GEN = cp437-ms-1996.tbl cp437-ms-1996.tbl \
          cp850-ms-1996.tbl cp850-ms-1996.tbl \
          cp874-ms-2000.tbl \
          cp932-ms-1996.tbl cp932-ms-1997.tbl \
          cp936-ms-1997.tbl cp936-ms-2000.tbl \
          cp949-ms-1996.tbl cp949-ms-2000.tbl \
          cp950-ms-1996.tbl cp950-ms-2000.tbl \
          cp1250-ms-2000.tbl cp1251-ms-2000.tbl \
          cp1252-ms-2000.tbl cp1253-ms-2000.tbl \
          cp1254-ms-2000.tbl cp1256-ms-2000.tbl \
          cp1257-ms-2000.tbl cp1258-ms-2000.tbl \
          cp20127-ms-2000r.tbl
TBL_ALL = $(TBL_GEN) \
          cp037-ms.tbl \
          cp500-ms.tbl \
          cp708-ms.tbl \
          cp720-ms.tbl \
          cp852-ms.tbl \
          cp860-ms.tbl cp861-ms.tbl cp862-ms.tbl cp863-ms.tbl \
          cp865-ms.tbl \
          cp866-ms.tbl \
          cp874-ms-1998.tbl \
          cp1250-ms-1995.tbl cp1250-ms-1997.tbl \
          cp1251-ms-1995.tbl cp1251-ms-1997.tbl \
          cp1252-ms-1995.tbl cp1252-ms-1997.tbl \
          cp1253-ms-1995.tbl cp1253-ms-1997.tbl \
          cp1254-ms-1995.tbl cp1254-ms-1997.tbl \
          cp1255-ms-1998.tbl \
          cp1256-ms-1998.tbl \
          cp1257-ms-1995.tbl cp1257-ms-1997.tbl \
          cp1258-ms-1997.tbl \
          cp1361-ms-1996.tbl \
          cp10000-ms.tbl cp10001-ms.tbl cp10004-ms.tbl \
          cp10079-ms.tbl \
          cp20000-ms.tbl \
          cp20261-ms.tbl cp20127-ms-2000.tbl \
          cp20269-ms-1996.tbl cp20290-ms.tbl \
          cp20866-ms-1996.tbl \
          cp20932-ms.tbl cp20936-ms.tbl cp20949-ms.tbl \
          cp21027-ms.tbl cp21866-ms-1996.tbl \
          cp28591-ms-1996.tbl \
          cp28592-ms-1995.tbl cp28592-ms-1996.tbl \
          cp28593-ms-1995.tbl cp28593-ms-1996.tbl \
          cp28594-ms-1995.tbl cp28594-ms-1996.tbl \
          cp28595-ms-1996.tbl \
          cp28596-ms-1995.tbl cp28596-ms-1996.tbl \
          cp28597-ms-1995.tbl cp28597-ms-1996.tbl \
          cp28598-ms-1996.tbl \
          cp28599-ms-1996.tbl \
          cp28605-ms-1999.tbl

all: $(TBL_ALL:.tbl=.ucm)
all-tbl: $(TBL_GEN)

%.tbl: %.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

%.pm: %.tbl $(TBL2PM) $(PLDIR)internal.pl
	$(PERLI) $(TBL2PM) $< > $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~
	rm -rfv $(TBL_ALL:.tbl=.ucm) $(TBL_GEN)
