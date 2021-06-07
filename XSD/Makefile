# run xmllint schema validation test on all xml files

# make sure xmllint is avaible
ifeq (, $(shell which xmllint))
 $(error "no xmllint in $(PATH), xmllint is required to run validation")
 endif

# xml files to be tested
EVENT_XMLS:=$(wildcard ../XML/*Event*.xml) $(wildcard ../XML/*/*Event*.xml)
VOCABULARY_XMLS:=$(wildcard ../XML/*Vocabulary*.xml) $(wildcard ../XML/*/*Vocabulary*.xml)

# create tests from filenames
EVENT_XMLTESTS:=$(patsubst %.xml,%.event-test,$(EVENT_XMLS))
VOCABULARY_XMLTESTS:=$(patsubst %.xml,%.vocabulary-test,$(VOCABULARY_XMLS))

valid-events: $(EVENT_XMLTESTS)
valid-vocabulary: $(VOCABULARY_XMLTESTS)

valid: valid-events valid-vocabulary 


# Each test depends on the XML file
# Now we have a pattern on both sides of the generic rule
%.event-test: %.xml
	xmllint --noout --schema ./EPCglobal-epcis-2_0.xsd  $<

%.vocabulary-test: %.xml
	xmllint --noout --schema ./EPCglobal-epcis-masterdata-2_0.xsd  $<

.PHONY: all valid
