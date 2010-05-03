PERL = perl
PERL_OPTIONS =
PERL_OPTIONS_ALL = $(PERL_OPTIONS)
PERL_ = $(PERL) $(PERL_OPTIONS_ALL)
PERL_INPLACE = $(PERL_) -n -i
ECHO = echo
CP = cp

BIN_DIR = ../bin/
TBR_DIR = ../source/
RESULT_DIR = ../generated/

TBR2TBL_PL = $(BIN_DIR)tbr2tbl.pl
TBR2TBL = $(PERL_) $(TBR2TBL_PL)

TBL2UCM_PL = $(BIN_DIR)tbl2ucm.pl
TBL2UCM = $(PERL_) $(TBL2UCM_PL)

GL_JIS_TBR_FILES = $(TBR_DIR)gl-jisx0208-common.tbr $(TBR_DIR)gl-cjk-hiragana.tbr \
  $(TBR_DIR)gl-cjk-katakana.tbr $(TBR_DIR)gl-cjk-greek.tbr $(TBR_DIR)gl-cjk-cyrillic.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-cjk-box-drawing.tbr

GENERATED_TBR_FILES = gl-jis-1997.tbr gl-jis-1997-swapped.tbr \
  gl-jis-1983.tbr gl-jis-1978.tbr

all: \
  $(GENERATED_TBR_FILES:%.tbr=$(RESULT_DIR)%.tbl) \
  $(GENERATED_TBR_FILES:%.tbr=$(RESULT_DIR)%.ucm)

$(RESULT_DIR)%.tbl: %.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

$(RESULT_DIR)%.ucm: $(RESULT_DIR)%.tbl $(TBL2UCM_PL)
	$(TBL2UCM) $< > $@

gl-jis-1997.tbr: $(TBR_DIR)jisx0208_1997.tbr $(GL_JIS_TBR_FILES) \
  $(TBR_DIR)gl-iso-646-symbol.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(ECHO) '#?o name="gl-jis-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1997-swapped.tbr: gl-jis-1997.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:3033|724D|3229|7274|3342|695A|3349|5978|3376|635E|3443|5E75|3452|6B5D|375B|7074|395C|6268|3C49|6922|3F59|7057|4128|6C4D|445B|5464|4557|626A|456E|5B6D|4573|5E39|4676|6D6E|4768|6A24|4930|5B58|4B79|5056|4C79|692E|4F36|6446|3646|4B6A|4D5A|6076|742[1234])/' $@
	$(ECHO) '0x3033	U+9C3A		# <cjk>' >> $@
	$(ECHO) '0x724D	U+9BF5		# <cjk>' >> $@
	$(ECHO) '0x3229	U+9DAF		# <cjk>' >> $@
	$(ECHO) '0x7274	U+9D2C		# <cjk>' >> $@
	$(ECHO) '0x3342	U+8823		# <cjk>' >> $@
	$(ECHO) '0x695A	U+86CE		# <cjk>' >> $@
	$(ECHO) '0x3349	U+652A		# <cjk>' >> $@
	$(ECHO) '0x5978	U+64B9		# <cjk>' >> $@
	$(ECHO) '0x3376	U+7AC8		# <cjk>' >> $@
	$(ECHO) '0x635E	U+7AC3		# <cjk>' >> $@
	$(ECHO) '0x3443	U+704C		# <cjk>' >> $@
	$(ECHO) '0x5E75	U+6F45		# <cjk>' >> $@
	$(ECHO) '0x3452	U+8AEB		# <cjk>' >> $@
	$(ECHO) '0x6B5D	U+8ACC		# <cjk>' >> $@
	$(ECHO) '0x375B	U+9838		# <cjk>' >> $@
	$(ECHO) '0x7074	U+981A		# <cjk>' >> $@
	$(ECHO) '0x395C	U+7926		# <cjk>' >> $@
	$(ECHO) '0x6268	U+783F		# <cjk>' >> $@
	$(ECHO) '0x3C49	U+8602		# <cjk>' >> $@
	$(ECHO) '0x6922	U+854A		# <cjk>' >> $@
	$(ECHO) '0x3F59	U+9771		# <cjk>' >> $@
	$(ECHO) '0x7057	U+976D		# <cjk>' >> $@
	$(ECHO) '0x4128	U+8CE4		# <cjk>' >> $@
	$(ECHO) '0x6C4D	U+8CCE		# <cjk>' >> $@
	$(ECHO) '0x445B	U+58FA		# <cjk>' >> $@
	$(ECHO) '0x5464	U+58F7		# <cjk>' >> $@
	$(ECHO) '0x4557	U+792A		# <cjk>' >> $@
	$(ECHO) '0x626A	U+783A		# <cjk>' >> $@
	$(ECHO) '0x456E	U+6AAE		# <cjk>' >> $@
	$(ECHO) '0x5B6D	U+68BC		# <cjk>' >> $@
	$(ECHO) '0x4573	U+6FE4		# <cjk>' >> $@
	$(ECHO) '0x5E39	U+6D9B		# <cjk>' >> $@
	$(ECHO) '0x4676	U+9087		# <cjk>' >> $@
	$(ECHO) '0x6D6E	U+8FE9		# <cjk>' >> $@
	$(ECHO) '0x4768	U+8805		# <cjk>' >> $@
	$(ECHO) '0x6A24	U+877F		# <cjk>' >> $@
	$(ECHO) '0x4930	U+6A9C		# <cjk>' >> $@
	$(ECHO) '0x5B58	U+6867		# <cjk>' >> $@
	$(ECHO) '0x4B79	U+5118		# <cjk>' >> $@
	$(ECHO) '0x5056	U+4FAD		# <cjk>' >> $@
	$(ECHO) '0x4C79	U+85EA		# <cjk>' >> $@
	$(ECHO) '0x692E	U+85AE		# <cjk>' >> $@
	$(ECHO) '0x4F36	U+7C60		# <cjk>' >> $@
	$(ECHO) '0x6446	U+7BED		# <cjk>' >> $@
	$(ECHO) '0x3646	U+582F		# <cjk>' >> $@
	$(ECHO) '0x4B6A	U+69C7		# <cjk>' >> $@
	$(ECHO) '0x4D5A	U+9059		# <cjk>' >> $@
	$(ECHO) '0x6076	U+7464		# <cjk>' >> $@
	$(ECHO) '0x7421	U+5C2D		# <cjk>' >> $@
	$(ECHO) '0x7422	U+69D9		# <cjk>' >> $@
	$(ECHO) '0x7423	U+9065		# <cjk>' >> $@
	$(ECHO) '0x7424	U+7476		# <cjk>' >> $@
	$(ECHO) '#?o name="gl-jis-1997-swapped"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1983.tbr: gl-jis-1997.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x742[56]/' $@
	$(ECHO) '#?o name="gl-jis-1983"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1978.tbr: gl-jis-1983.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:3033|724D|3229|7274|3342|695A|3349|5978|3376|635E|3443|5E75|3452|6B5D|375B|7074|395C|6268|3C49|6922|3F59|7057|4128|6C4D|445B|5464|4557|626A|456E|5B6D|4573|5E39|4676|6D6E|4768|6A24|4930|5B58|4B79|5056|4C79|692E|4F36|6446|3646|4B6A|4D5A|6076)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:2(?:2[3-7]|8)|3022|316B|322A|337A|3622|366D|3834|396D|3C48|3D2B|3E5[5F]|4066|415F|424D|433D|444F|453[6F]|4578|4642|4739|482E|4830|4B4B|4C4D|4D69|4F39|5A39|74)/' $@
	$(ECHO) '0x3033	U+9C3A		# <cjk>' >> $@
	$(ECHO) '0x724D	U+9BF5		# <cjk>' >> $@
	$(ECHO) '0x3229	U+9DAF		# <cjk>' >> $@
	$(ECHO) '0x7274	U+9D2C		# <cjk>' >> $@
	$(ECHO) '0x3342	U+8823		# <cjk>' >> $@
	$(ECHO) '0x695A	U+86CE		# <cjk>' >> $@
	$(ECHO) '0x3349	U+652A		# <cjk>' >> $@
	$(ECHO) '0x5978	U+64B9		# <cjk>' >> $@
	$(ECHO) '0x3376	U+7AC8		# <cjk>' >> $@
	$(ECHO) '0x635E	U+7AC3		# <cjk>' >> $@
	$(ECHO) '0x3443	U+704C		# <cjk>' >> $@
	$(ECHO) '0x5E75	U+6F45		# <cjk>' >> $@
	$(ECHO) '0x3452	U+8AEB		# <cjk>' >> $@
	$(ECHO) '0x6B5D	U+8ACC		# <cjk>' >> $@
	$(ECHO) '0x375B	U+9838		# <cjk>' >> $@
	$(ECHO) '0x7074	U+981A		# <cjk>' >> $@
	$(ECHO) '0x395C	U+7926		# <cjk>' >> $@
	$(ECHO) '0x6268	U+783F		# <cjk>' >> $@
	$(ECHO) '0x3C49	U+8602		# <cjk>' >> $@
	$(ECHO) '0x6922	U+854A		# <cjk>' >> $@
	$(ECHO) '0x3F59	U+9771		# <cjk>' >> $@
	$(ECHO) '0x7057	U+976D		# <cjk>' >> $@
	$(ECHO) '0x4128	U+8CE4		# <cjk>' >> $@
	$(ECHO) '0x6C4D	U+8CCE		# <cjk>' >> $@
	$(ECHO) '0x445B	U+58FA		# <cjk>' >> $@
	$(ECHO) '0x5464	U+58F7		# <cjk>' >> $@
	$(ECHO) '0x4557	U+792A		# <cjk>' >> $@
	$(ECHO) '0x626A	U+783A		# <cjk>' >> $@
	$(ECHO) '0x456E	U+6AAE		# <cjk>' >> $@
	$(ECHO) '0x5B6D	U+68BC		# <cjk>' >> $@
	$(ECHO) '0x4573	U+6FE4		# <cjk>' >> $@
	$(ECHO) '0x5E39	U+6D9B		# <cjk>' >> $@
	$(ECHO) '0x4676	U+9087		# <cjk>' >> $@
	$(ECHO) '0x6D6E	U+8FE9		# <cjk>' >> $@
	$(ECHO) '0x4768	U+8805		# <cjk>' >> $@
	$(ECHO) '0x6A24	U+877F		# <cjk>' >> $@
	$(ECHO) '0x4930	U+6A9C		# <cjk>' >> $@
	$(ECHO) '0x5B58	U+6867		# <cjk>' >> $@
	$(ECHO) '0x4B79	U+5118		# <cjk>' >> $@
	$(ECHO) '0x5056	U+4FAD		# <cjk>' >> $@
	$(ECHO) '0x4C79	U+85EA		# <cjk>' >> $@
	$(ECHO) '0x692E	U+85AE		# <cjk>' >> $@
	$(ECHO) '0x4F36	U+7C60		# <cjk>' >> $@
	$(ECHO) '0x6446	U+7BED		# <cjk>' >> $@
	$(ECHO) '0x3646	U+582F		# <cjk>' >> $@
	$(ECHO) '0x4B6A	U+69C7		# <cjk>' >> $@
	$(ECHO) '0x4D5A	U+9059		# <cjk>' >> $@
	$(ECHO) '0x6076	U+7464		# <cjk>' >> $@
	## 29 characters from JIS X 0208:1997 6.3.4
	$(ECHO) '0x3022	U+555E		# <cjk>' >> $@
	$(ECHO) '0x316B	U+7130		# <cjk>' >> $@
	$(ECHO) '0x322A	U+9DD7		# <cjk>' >> $@
	$(ECHO) '0x337A	U+5699		# <cjk>' >> $@
	$(ECHO) '0x3622	U+4FE0		# <cjk>' >> $@
	$(ECHO) '0x366D	U+8ED0		# <cjk>' >> $@
	$(ECHO) '0x3834	U+9E7C		# <cjk>' >> $@
	$(ECHO) '0x396D	U+9EB4		# <cjk>' >> $@
	$(ECHO) '0x3C48	U+5C62		# <cjk>' >> $@
	$(ECHO) '0x3D2B	U+7E61		# <cjk>' >> $@
	$(ECHO) '0x3E55	U+8523		# <cjk>' >> $@
	$(ECHO) '0x3E5F	U+91AC		# <cjk>' >> $@
	$(ECHO) '0x4066	U+87EC		# <cjk>' >> $@
	$(ECHO) '0x415F	U+6414		# <cjk>' >> $@
	$(ECHO) '0x424D	U+9A52		# <cjk>' >> $@
	$(ECHO) '0x433D	U+7C1E		# <cjk>' >> $@
	$(ECHO) '0x444F	U+6451		# <cjk>' >> $@
	$(ECHO) '0x4536	U+5861		# <cjk>' >> $@
	$(ECHO) '0x453F	U+985A		# <cjk>' >> $@
	$(ECHO) '0x4578	U+79B1		# <cjk>' >> $@
	$(ECHO) '0x4642	U+7006		# <cjk>' >> $@
	$(ECHO) '0x4739	U+56CA		# <cjk>' >> $@
	$(ECHO) '0x482E	U+6F51		# <cjk>' >> $@
	$(ECHO) '0x4830	U+91B1		# <cjk>' >> $@
	$(ECHO) '0x4B4B	U+9830		# <cjk>' >> $@
	$(ECHO) '0x4C4D	U+9EB5		# <cjk>' >> $@
	$(ECHO) '0x4D69	U+840A		# <cjk>' >> $@
	$(ECHO) '0x4F39	U+881F		# <cjk>' >> $@
	$(ECHO) '0x5A39	U+6522		# <cjk>' >> $@
	$(ECHO) '#?o name="gl-jis-1978"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

## License: Public Domain.
