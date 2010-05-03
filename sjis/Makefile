PERL = perl
PERL_OPTIONS =
PERL_OPTIONS_ALL = $(PERL_OPTIONS)
PERL_ = $(PERL) $(PERL_OPTIONS_ALL)
PERL_INPLACE = $(PERL_) -n -i
ECHO = echo
CP = cp

BIN_DIR = ../bin/
TBR_DIR = ../source/
GENERATED_TBR_DIR = ../generated/
RESULT_DIR = ../generated/
CPTBR_DIR = ../cp/

TBR2TBL_PL = $(BIN_DIR)tbr2tbl.pl
TBR2TBL = $(PERL_) $(TBR2TBL_PL)

TBL2UCM_PL = $(BIN_DIR)tbl2ucm.pl
TBL2UCM = $(PERL_) $(TBL2UCM_PL)

all: \
  $(RESULT_DIR)shift-jis-1997.tbl \
  $(RESULT_DIR)shift-jis-1997.ucm

$(GENERATED_TBR_DIR)shift-jis-1997.tbr: $(CPTBR_DIR)cp932-ms.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:5C|7E|8(?:[07]|1(?:5[CF]|6[01]|7C|9[12]|CA))|A0|F)|<-|->/' $@
	$(ECHO) '0x5C	U+00A5		# YEN SIGN' >> $@
	$(ECHO) '0x7E	U+203E		# OVERLINE' >> $@
	$(ECHO) '0x815C	U+2014		# EM DASH' >> $@
	$(ECHO) '0x815F	U+005C		# REVERSE SOLIDUS' >> $@
	$(ECHO) '0x8160	U+301C		# WAVE DASH' >> $@
	$(ECHO) '0x8161	U+2016		# DOUBLE VERTICAL LINE' >> $@
	$(ECHO) '0x817C	U+2212		# MINUS SIGN' >> $@
	$(ECHO) '0x8191	U+00A2		# CENT SIGN' >> $@
	$(ECHO) '0x8192	U+00A3		# POUND SIGN' >> $@
	$(ECHO) '0x81CA	U+00AC		# NOT SIGN' >> $@
	$(ECHO) '#?o name="shift-jis-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

$(RESULT_DIR)shift-jis-1997.tbl: $(RESULT_DIR)%.tbl: $(GENERATED_TBR_DIR)%.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

$(RESULT_DIR)%.ucm: $(RESULT_DIR)%.tbl $(TBL2UCM_PL)
	$(TBL2UCM) $< > $@

## License: Public Domain.
