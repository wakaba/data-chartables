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

$(GENERATED_TBR_DIR)euc-jp-1997-cs1-left.tbr: $(GL_JIS_TBR_FILES) \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR2TBL_PL) Makefile
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@.tmp
	$(ECHO) '#?import src="$(TBR_DIR)gl-jisx0208-common.tbr" mode="standard,fullwidth,isoiec646irv,NOT-SIGN,LARGE-CIRCLE,nonhan-1983-add,han-1978-revised,han-1983-revised,han-1983-swapped,han-1983-add,han-1990-revised,han-1990-add"' >> $@.tmp
	$(TBR2TBL) $@.tmp > $@
	$(RM) $@.tmp

$(GENERATED_TBR_DIR)euc-jp-1997.tbr: Makefile
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@
	$(ECHO) '#?import std-cl' >> $@
	$(ECHO) '#?import std-0x20' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-iso-646-alphanumeric.tbr"' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-iso-646-symbol.tbr"' >> $@
	$(ECHO) '#?import std-0x7F' >> $@
	$(ECHO) '0x80	U+0080		# <control>' >> $@
	$(ECHO) '0x81	U+0081		# <control>' >> $@
	$(ECHO) '0x82	U+0082		# <control>' >> $@
	$(ECHO) '0x83	U+0083		# <control>' >> $@
	$(ECHO) '0x84	U+0084		# <control>' >> $@
	$(ECHO) '0x85	U+0085		# <control>' >> $@
	$(ECHO) '0x86	U+0086		# <control>' >> $@
	$(ECHO) '0x87	U+0087		# <control>' >> $@
	$(ECHO) '0x88	U+0088		# <control>' >> $@
	$(ECHO) '0x89	U+0089		# <control>' >> $@
	$(ECHO) '0x8A	U+008A		# <control>' >> $@
	$(ECHO) '0x8B	U+008B		# <control>' >> $@
	$(ECHO) '0x8C	U+008C		# <control>' >> $@
	$(ECHO) '0x8D	U+008D		# <control>' >> $@
	$(ECHO) '0x90	U+0090		# <control>' >> $@
	$(ECHO) '0x91	U+0091		# <control>' >> $@
	$(ECHO) '0x92	U+0092		# <control>' >> $@
	$(ECHO) '0x93	U+0093		# <control>' >> $@
	$(ECHO) '0x94	U+0094		# <control>' >> $@
	$(ECHO) '0x95	U+0095		# <control>' >> $@
	$(ECHO) '0x96	U+0096		# <control>' >> $@
	$(ECHO) '0x97	U+0097		# <control>' >> $@
	$(ECHO) '0x98	U+0098		# <control>' >> $@
	$(ECHO) '0x99	U+0099		# <control>' >> $@
	$(ECHO) '0x9A	U+009A		# <control>' >> $@
	$(ECHO) '0x9B	U+009B		# <control>' >> $@
	$(ECHO) '0x9C	U+009C		# <control>' >> $@
	$(ECHO) '0x9D	U+009D		# <control>' >> $@
	$(ECHO) '0x9E	U+009E		# <control>' >> $@
	$(ECHO) '0x9F	U+009F		# <control>' >> $@
	$(PERL_INPLACE) -e 'print unless /^0x8[EF]/' $@
	$(ECHO) '#?import std-0xA0' >> $@
	$(ECHO) '#?import std-0xFF' >> $@
	$(ECHO) '#?import src="euc-jp-1997-cs1-left.tbr" right' >> $@
	$(ECHO) '0x8EA1	U+FF61		# HALFWIDTH IDEOGRAPHIC FULL STOP' >> $@
	$(ECHO) '0x8EA2	U+FF62		# HALFWIDTH LEFT CORNER BRACKET' >> $@
	$(ECHO) '0x8EA3	U+FF63		# HALFWIDTH RIGHT CORNER BRACKET' >> $@
	$(ECHO) '0x8EA4	U+FF64		# HALFWIDTH IDEOGRAPHIC COMMA' >> $@
	$(ECHO) '0x8EA5	U+FF65		# HALFWIDTH KATAKANA MIDDLE DOT' >> $@
	$(ECHO) '0x8EA6	U+FF66		# HALFWIDTH KATAKANA LETTER WO' >> $@
	$(ECHO) '0x8EA7	U+FF67		# HALFWIDTH KATAKANA LETTER SMALL A' >> $@
	$(ECHO) '0x8EA8	U+FF68		# HALFWIDTH KATAKANA LETTER SMALL I' >> $@
	$(ECHO) '0x8EA9	U+FF69		# HALFWIDTH KATAKANA LETTER SMALL U' >> $@
	$(ECHO) '0x8EAA	U+FF6A		# HALFWIDTH KATAKANA LETTER SMALL E' >> $@
	$(ECHO) '0x8EAB	U+FF6B		# HALFWIDTH KATAKANA LETTER SMALL O' >> $@
	$(ECHO) '0x8EAC	U+FF6C		# HALFWIDTH KATAKANA LETTER SMALL YA' >> $@
	$(ECHO) '0x8EAD	U+FF6D		# HALFWIDTH KATAKANA LETTER SMALL YU' >> $@
	$(ECHO) '0x8EAE	U+FF6E		# HALFWIDTH KATAKANA LETTER SMALL YO' >> $@
	$(ECHO) '0x8EAF	U+FF6F		# HALFWIDTH KATAKANA LETTER SMALL TU' >> $@
	$(ECHO) '0x8EB0	U+FF70		# HALFWIDTH KATAKANA-HIRAGANA PROLONGED SOUND MARK' >> $@
	$(ECHO) '0x8EB1	U+FF71		# HALFWIDTH KATAKANA LETTER A' >> $@
	$(ECHO) '0x8EB2	U+FF72		# HALFWIDTH KATAKANA LETTER I' >> $@
	$(ECHO) '0x8EB3	U+FF73		# HALFWIDTH KATAKANA LETTER U' >> $@
	$(ECHO) '0x8EB4	U+FF74		# HALFWIDTH KATAKANA LETTER E' >> $@
	$(ECHO) '0x8EB5	U+FF75		# HALFWIDTH KATAKANA LETTER O' >> $@
	$(ECHO) '0x8EB6	U+FF76		# HALFWIDTH KATAKANA LETTER KA' >> $@
	$(ECHO) '0x8EB7	U+FF77		# HALFWIDTH KATAKANA LETTER KI' >> $@
	$(ECHO) '0x8EB8	U+FF78		# HALFWIDTH KATAKANA LETTER KU' >> $@
	$(ECHO) '0x8EB9	U+FF79		# HALFWIDTH KATAKANA LETTER KE' >> $@
	$(ECHO) '0x8EBA	U+FF7A		# HALFWIDTH KATAKANA LETTER KO' >> $@
	$(ECHO) '0x8EBB	U+FF7B		# HALFWIDTH KATAKANA LETTER SA' >> $@
	$(ECHO) '0x8EBC	U+FF7C		# HALFWIDTH KATAKANA LETTER SI' >> $@
	$(ECHO) '0x8EBD	U+FF7D		# HALFWIDTH KATAKANA LETTER SU' >> $@
	$(ECHO) '0x8EBE	U+FF7E		# HALFWIDTH KATAKANA LETTER SE' >> $@
	$(ECHO) '0x8EBF	U+FF7F		# HALFWIDTH KATAKANA LETTER SO' >> $@
	$(ECHO) '0x8EC0	U+FF80		# HALFWIDTH KATAKANA LETTER TA' >> $@
	$(ECHO) '0x8EC1	U+FF81		# HALFWIDTH KATAKANA LETTER TI' >> $@
	$(ECHO) '0x8EC2	U+FF82		# HALFWIDTH KATAKANA LETTER TU' >> $@
	$(ECHO) '0x8EC3	U+FF83		# HALFWIDTH KATAKANA LETTER TE' >> $@
	$(ECHO) '0x8EC4	U+FF84		# HALFWIDTH KATAKANA LETTER TO' >> $@
	$(ECHO) '0x8EC5	U+FF85		# HALFWIDTH KATAKANA LETTER NA' >> $@
	$(ECHO) '0x8EC6	U+FF86		# HALFWIDTH KATAKANA LETTER NI' >> $@
	$(ECHO) '0x8EC7	U+FF87		# HALFWIDTH KATAKANA LETTER NU' >> $@
	$(ECHO) '0x8EC8	U+FF88		# HALFWIDTH KATAKANA LETTER NE' >> $@
	$(ECHO) '0x8EC9	U+FF89		# HALFWIDTH KATAKANA LETTER NO' >> $@
	$(ECHO) '0x8ECA	U+FF8A		# HALFWIDTH KATAKANA LETTER HA' >> $@
	$(ECHO) '0x8ECB	U+FF8B		# HALFWIDTH KATAKANA LETTER HI' >> $@
	$(ECHO) '0x8ECC	U+FF8C		# HALFWIDTH KATAKANA LETTER HU' >> $@
	$(ECHO) '0x8ECD	U+FF8D		# HALFWIDTH KATAKANA LETTER HE' >> $@
	$(ECHO) '0x8ECE	U+FF8E		# HALFWIDTH KATAKANA LETTER HO' >> $@
	$(ECHO) '0x8ECF	U+FF8F		# HALFWIDTH KATAKANA LETTER MA' >> $@
	$(ECHO) '0x8ED0	U+FF90		# HALFWIDTH KATAKANA LETTER MI' >> $@
	$(ECHO) '0x8ED1	U+FF91		# HALFWIDTH KATAKANA LETTER MU' >> $@
	$(ECHO) '0x8ED2	U+FF92		# HALFWIDTH KATAKANA LETTER ME' >> $@
	$(ECHO) '0x8ED3	U+FF93		# HALFWIDTH KATAKANA LETTER MO' >> $@
	$(ECHO) '0x8ED4	U+FF94		# HALFWIDTH KATAKANA LETTER YA' >> $@
	$(ECHO) '0x8ED5	U+FF95		# HALFWIDTH KATAKANA LETTER YU' >> $@
	$(ECHO) '0x8ED6	U+FF96		# HALFWIDTH KATAKANA LETTER YO' >> $@
	$(ECHO) '0x8ED7	U+FF97		# HALFWIDTH KATAKANA LETTER RA' >> $@
	$(ECHO) '0x8ED8	U+FF98		# HALFWIDTH KATAKANA LETTER RI' >> $@
	$(ECHO) '0x8ED9	U+FF99		# HALFWIDTH KATAKANA LETTER RU' >> $@
	$(ECHO) '0x8EDA	U+FF9A		# HALFWIDTH KATAKANA LETTER RE' >> $@
	$(ECHO) '0x8EDB	U+FF9B		# HALFWIDTH KATAKANA LETTER RO' >> $@
	$(ECHO) '0x8EDC	U+FF9C		# HALFWIDTH KATAKANA LETTER WA' >> $@
	$(ECHO) '0x8EDD	U+FF9D		# HALFWIDTH KATAKANA LETTER N' >> $@
	$(ECHO) '0x8EDE	U+FF9E		# HALFWIDTH KATAKANA VOICED SOUND MARK' >> $@
	$(ECHO) '0x8EDF	U+FF9F		# HALFWIDTH KATAKANA SEMI-VOICED SOUND MARK' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-jisx0212-common.tbr" mode="fullwidth,isoiec646irv,BROKEN-BAR,han" offset="0x8F8080"' >> $@

$(RESULT_DIR)euc-jp-1997.tbl: $(RESULT_DIR)%.tbl: $(GENERATED_TBR_DIR)%.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-iso-646-symbol.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR_DIR)gl-jisx0212-common.tbr \
  $(GENERATED_TBR_DIR)euc-jp-1997-cs1-left.tbr $(TBR2TBL_PL)
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
