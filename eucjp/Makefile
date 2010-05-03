PERL = perl
PERL_OPTIONS =
PERL_OPTIONS_ALL = $(PERL_OPTIONS)
PERL_ = $(PERL) $(PERL_OPTIONS_ALL)
PERL_INPLACE = $(PERL_) -n -i
ECHO = echo
CP = cp
CAT = cat

BIN_DIR = ../bin/
TBR_DIR = ../source/
GENERATED_TBR_DIR = ../generated/
RESULT_DIR = ../generated/
EUCTBL_DIR = ./

TBR2TBL_PL = $(BIN_DIR)tbr2tbl.pl
TBR2TBL = $(PERL_) $(TBR2TBL_PL)

TBL2UCM_PL = $(BIN_DIR)tbl2ucm.pl
TBL2UCM = $(PERL_) $(TBL2UCM_PL)

GL_JIS_TBR_FILES = $(TBR_DIR)gl-jisx0208-common.tbr $(TBR_DIR)gl-cjk-hiragana.tbr \
  $(TBR_DIR)gl-cjk-katakana.tbr $(TBR_DIR)gl-cjk-greek.tbr $(TBR_DIR)gl-cjk-cyrillic.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-cjk-box-drawing.tbr

all: \
  $(RESULT_DIR)euc-jp-1997.tbl \
  $(RESULT_DIR)euc-jp-1997-open-nec.tbl \
  $(RESULT_DIR)euc-jp-sw.tbl \
  $(RESULT_DIR)euc-jp-1997.ucm \
  $(RESULT_DIR)euc-jp-1997-open-nec.ucm \
  $(RESULT_DIR)euc-jp-sw.ucm \

$(RESULT_DIR)euc-jp-1997-cs1-left.tbl: $(RESULT_DIR)%.tbl: %.tbr \
  $(GL_JIS_TBR_FILES) \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

$(RESULT_DIR)euc-jp-1997.tbl: $(RESULT_DIR)%.tbl: %.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-iso-646-symbol.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR_DIR)gl-jisx0212-common.tbr \
  $(RESULT_DIR)euc-jp-1997-cs1-left.tbl $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

$(RESULT_DIR)euc-jp-1997-open-nec.tbl:
	$(CP) $(TBL_DIR)euc-jp-1997-open-nec.tbl $@.tmp
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-1997-open-nec"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(CAT) $@.tmp >> $@
	$(RM) $@.tmp

$(RESULT_DIR)euc-jp-sw.tbl:
	$(CP) $(TBL_DIR)euc-jp-sw.tbl $@.tmp
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-sw"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(CAT) $@.tmp >> $@
	$(RM) $@.tmp

$(RESULT_DIR)%.ucm: $(RESULT_DIR)%.tbl $(TBL2UCM_PL)
	$(TBL2UCM) $< > $@

$(RESULT_DIR)%.ucm: $(EUCTBL_DIR)%.tbl $(TBL2UCM_PL)
	$(TBL2UCM) $< > $@

## License: Public Domain.
