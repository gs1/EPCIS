# run Xalan XSL transformation and validate agains version 1.2.4 XSD

# make sure Xalan is avaible
ifeq (, $(shell which Xalan))
 $(error "no Xalan in $(PATH), Xalan is required to run transformation")
 endif

# make sure xmllint is avaible
ifeq (, $(shell which xmllint))
 $(error "no xmllint in $(PATH), xmllint is required to run validation")
 endif

all : valid
.PHONY : all

# xml files to be tested
#TRANSFORMATION_XMLS:=$(wildcard ../XML/*.xml) $(wildcard ../XML/*Event*/*.xml) $(wildcard ../XML/With*/*.xml) $(wildcard ../XML/Mimasu/Example?.xml) $(wildcard ../XML/Mimasu/*Event*.xml)
# only ObjectEvent, TranformationEvent and AggregationEvent are supported (as of now)

# ObjectEvents only
TRANSFORM_OBJECTEVENT_XMLS:=../XML/CBV/CBV-11.1-2020-06-16a.xml ../XML/CBV/CBV-11.2-2020-06-16a.xml ../XML/CBV/CBV-11.3-2020-06-16a.xml ../XML/Example_9.6.1-ObjectEvent-2020_06_18a.xml ../XML/Mimasu/Example1.xml ../XML/Mimasu/Example2.xml 

# TransformationEvents only
TRANSFORM_TRANSFORMATIONEVENT_XMLS:=../XML/Mimasu/Example4.xml ../XML/WithErrorDeclaration/ErrorDeclarationAndCorrectiveEvent.xml

# TransformationEvents only
TRANSFORM_AGGREGATIONEVENT_XMLS:=../XML/Mimasu/Example3.xml

#../XML/WithSensorData/SensorDataExamples.xml


# create tests from filenames
TRANSFORM_OBJECTEVENT_TESTS:=$(patsubst %.xml,%.object-event-test,$(TRANSFORM_OBJECTEVENT_XMLS))
TRANSFORM_TRANSFORMATIONEVENT_TESTS:=$(patsubst %.xml,%.transformation-event-test,$(TRANSFORM_TRANSFORMATIONEVENT_XMLS))
TRANSFORM_AGGREGATIONEVENT_TESTS:=$(patsubst %.xml,%.aggregation-event-test,$(TRANSFORM_AGGREGATIONEVENT_XMLS))

object-events: $(TRANSFORM_OBJECTEVENT_TESTS)
transformation-events: $(TRANSFORM_TRANSFORMATIONEVENT_TESTS)
aggregation-events: $(TRANSFORM_AGGREGATIONEVENT_TESTS)

valid: object-events transformation-events aggregation-events


%.object-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.transformation-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.aggregation-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
