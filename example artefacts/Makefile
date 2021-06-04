# run xmllint schema validation test on all xml files

# make sure xmllint is avaible
ifeq (, $(shell which xmllint))
 $(error "no xmllint in $(PATH), xmllint is required to run checks")
 endif

# xml files to be tested
XMLS:=$(wildcard *.xml)

# create tests from filenames
XMLTESTS:=$(patsubst %.xml,%.test,$(XMLS))

check: $(XMLTESTS)

# Each test depends on the XML file
# Now we have a pattern on both sides of the generic rule
%.test: %.xml
	xmllint --noout --schema ../XSD/EPCglobal-epcis-2_0.xsd  $<

.PHONY: all check
