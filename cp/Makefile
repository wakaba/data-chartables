
PLDIR = ../tool/
CP = cp
PERL = perl
PERLI = $(PERL) -I$(PLDIR)
TBR2TBL = $(PLDIR)tbr2tbl.pl
TBL2UCM = $(PLDIR)tbl2ucm.pl

SOURCE_DIR = ./
RESULT_DIR = ../generated/

TBL_GEN = $(RESULT_DIR)fullwidth.tbl \
	  $(RESULT_DIR)cp437-ms-1996.tbl $(RESULT_DIR)cp437-ms-1996.tbl \
          $(RESULT_DIR)cp850-ms-1996.tbl $(RESULT_DIR)cp850-ms-1996.tbl \
          $(RESULT_DIR)cp874-ms-2000.tbl \
          $(RESULT_DIR)cp932-ms-1996.tbl $(RESULT_DIR)cp932-ms-1997.tbl \
          $(RESULT_DIR)cp936-ms-1997.tbl $(RESULT_DIR)cp936-ms-2000.tbl \
          $(RESULT_DIR)cp949-ms-1996.tbl $(RESULT_DIR)cp949-ms-2000.tbl \
          $(RESULT_DIR)cp950-ms-1996.tbl $(RESULT_DIR)cp950-ms-2000.tbl \
          $(RESULT_DIR)cp1250-ms-2000.tbl $(RESULT_DIR)cp1251-ms-2000.tbl \
          $(RESULT_DIR)cp1252-ms-2000.tbl $(RESULT_DIR)cp1253-ms-2000.tbl \
          $(RESULT_DIR)cp1254-ms-2000.tbl $(RESULT_DIR)cp1256-ms-2000.tbl \
          $(RESULT_DIR)cp1257-ms-2000.tbl $(RESULT_DIR)cp1258-ms-2000.tbl
TBL_STATIC = \
          $(RESULT_DIR)cp037-ms.tbl \
          $(RESULT_DIR)cp500-ms.tbl \
          $(RESULT_DIR)cp708-ms.tbl \
          $(RESULT_DIR)cp720-ms.tbl \
          $(RESULT_DIR)cp852-ms.tbl \
          $(RESULT_DIR)cp860-ms.tbl $(RESULT_DIR)cp861-ms.tbl $(RESULT_DIR)cp862-ms.tbl $(RESULT_DIR)cp863-ms.tbl \
          $(RESULT_DIR)cp865-ms.tbl \
          $(RESULT_DIR)cp866-ms.tbl \
          $(RESULT_DIR)cp874-ms-1998.tbl \
          $(RESULT_DIR)cp1250-ms-1995.tbl $(RESULT_DIR)cp1250-ms-1997.tbl \
          $(RESULT_DIR)cp1251-ms-1995.tbl $(RESULT_DIR)cp1251-ms-1997.tbl \
          $(RESULT_DIR)cp1252-ms-1995.tbl $(RESULT_DIR)cp1252-ms-1997.tbl \
          $(RESULT_DIR)cp1253-ms-1995.tbl $(RESULT_DIR)cp1253-ms-1997.tbl \
          $(RESULT_DIR)cp1254-ms-1995.tbl $(RESULT_DIR)cp1254-ms-1997.tbl \
          $(RESULT_DIR)cp1255-ms-1998.tbl \
          $(RESULT_DIR)cp1256-ms-1998.tbl \
          $(RESULT_DIR)cp1257-ms-1995.tbl $(RESULT_DIR)cp1257-ms-1997.tbl \
          $(RESULT_DIR)cp1258-ms-1997.tbl \
          $(RESULT_DIR)cp1361-ms-1996.tbl \
          $(RESULT_DIR)cp10000-ms.tbl $(RESULT_DIR)cp10001-ms.tbl $(RESULT_DIR)cp10004-ms.tbl \
          $(RESULT_DIR)cp10079-ms.tbl \
          $(RESULT_DIR)cp20000-ms.tbl \
          $(RESULT_DIR)cp20261-ms.tbl \
	  $(RESULT_DIR)cp20127-ms-2000.tbl \
          $(RESULT_DIR)cp20127-ms-2000r.tbl \
          $(RESULT_DIR)cp20269-ms-1996.tbl $(RESULT_DIR)cp20290-ms.tbl \
          $(RESULT_DIR)cp20866-ms-1996.tbl \
          $(RESULT_DIR)cp20932-ms-2000.tbl $(RESULT_DIR)cp20932-ms-2001.tbl \
	  $(RESULT_DIR)cp20936-ms.tbl $(RESULT_DIR)cp20949-ms.tbl \
          $(RESULT_DIR)cp21027-ms.tbl $(RESULT_DIR)cp21866-ms-1997.tbl \
          $(RESULT_DIR)cp28591-ms-1996.tbl \
          $(RESULT_DIR)cp28592-ms-1995.tbl $(RESULT_DIR)cp28592-ms-1996.tbl \
          $(RESULT_DIR)cp28593-ms-1995.tbl $(RESULT_DIR)cp28593-ms-1996.tbl \
          $(RESULT_DIR)cp28594-ms-1995.tbl $(RESULT_DIR)cp28594-ms-1996.tbl \
          $(RESULT_DIR)cp28595-ms-1996.tbl \
          $(RESULT_DIR)cp28596-ms-1995.tbl $(RESULT_DIR)cp28596-ms-1996.tbl \
          $(RESULT_DIR)cp28597-ms-1995.tbl $(RESULT_DIR)cp28597-ms-1996.tbl \
          $(RESULT_DIR)cp28598-ms-1996.tbl \
          $(RESULT_DIR)cp28599-ms-1996.tbl \
          $(RESULT_DIR)cp28605-ms-1999.tbl
TBL_STATIC_ORIG = $(TBL_STATIC:$(RESULT_DIR)%=$(SOURCE_DIR)%)
TBL_ALL = $(TBL_GEN) $(TBL_STATIC)

all: all-tbl $(TBL_ALL:.tbl=.ucm)
all-tbl: $(TBL_GEN) tbl-static-copy

tbl-static-copy: $(TBL_STATIC_ORIG)
	$(CP) --update $(TBL_STATIC_ORIG) $(RESULT_DIR)

$(RESULT_DIR)%.tbl: $(SOURCE_DIR)%.tbr $(TBR2TBL)
	$(PERLI) $(TBR2TBL) $< > $@

$(RESULT_DIR)%.ucm: $(RESULT_DIR)%.tbl $(TBL2UCM)
	$(PERLI) $(TBL2UCM) $< > $@

clean:
	rm -rfv *.BAK .*.BAK *~ .*~

## License: Public Domain.
