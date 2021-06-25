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
EVENT_XMLS:=$(wildcard ../XML/*.xml) $(wildcard ../XML/*Event*/*.xml) $(wildcard ../XML/With*/*.xml) $(wildcard ../XML/Mimasu/Example?.xml) $(wildcard ../XML/Mimasu/*Event*.xml) $(wildcard ../XML/WithExtension/*.xml)

# ObjectEvents only
OBJECTEVENT_XMLS:=../XML/CBV/CBV-11.1-2020-06-16a.xml ../XML/CBV/CBV-11.2-2020-06-16a.xml ../XML/CBV/CBV-11.3-2020-06-16a.xml ../XML/Example_9.6.1-ObjectEvent-2020_06_18a.xml ../XML/Mimasu/Example1.xml ../XML/Mimasu/Example2.xml ../XML/WithExtension/ObjectEvent.xml

# TransformationEvents only
TRANSFORMATIONEVENT_XMLS:=../XML/Mimasu/Example4.xml ../XML/WithErrorDeclaration/ErrorDeclarationAndCorrectiveEvent.xml ../XML/WithExtension/TransformationEvent.xml

# TransformationEvents only
AGGREGATIONEVENT_XMLS:=../XML/Mimasu/Example3.xml ../XML/WithExtension/AggregationEvent.xml

# TransactionEvents only
TRANSACTIONEVENT_XMLS:=../XML/Example-TransactionEvent-2020_07_03y.xml ../XML/WithExtension/TransactionEvent.xml

# AssociationEvent only
ASSOCIATIONEVENT_XMLS:=../XML/AssociationEvent/AssociationEventExamples.xml ../XML/Mimasu/Example-associatonEvent-sensor.xml ../XML/WithExtension/AssociationEvent.xml

# AssociationEvent only
WITHSENSORDATA_XMLS:=../XML/WithSensorData/SensorDataExamples.xml

# xml files to be tested
EVENT_XMLS_1_2:=1.2/XML/AggregationEvent.xml 1.2/XML/AssociationEvent.xml 1.2/XML/ObjectEvent.xml 1.2/XML/TransformationEvent.xml 1.2/XML/TransactionEvent.xml



# create tests 
EVENT_TESTS:=$(patsubst %.xml,%.event-test,$(EVENT_XMLS))

# create specific tests
OBJECTEVENT_TESTS:=$(patsubst %.xml,%.object-event-test,$(OBJECTEVENT_XMLS))
TRANSFORMATIONEVENT_TESTS:=$(patsubst %.xml,%.transformation-event-test,$(TRANSFORMATIONEVENT_XMLS))
GGREGATIONEVENT_TESTS:=$(patsubst %.xml,%.aggregation-event-test,$(AGGREGATIONEVENT_XMLS))
TRANSACTIONEVENT_TESTS:=$(patsubst %.xml,%.transaction-event-test,$(TRANSACTIONEVENT_XMLS))
ASSOCIATIONEVENT_TESTS:=$(patsubst %.xml,%.association-event-test,$(ASSOCIATIONEVENT_XMLS))
WITHSENSORDATA_TESTS:=$(patsubst %.xml,%.withsensordata-test,$(WITHSENSORDATA_XMLS))

# create tests for 1.2 to 2.0
EVENT_TESTS_1_2:=$(patsubst %.xml,%.event-test-1-2,$(EVENT_XMLS_1_2))

events: $(EVENT_TESTS)
object-events: $(OBJECTEVENT_TESTS)
transformation-events: $(TRANSFORMATIONEVENT_TESTS)
aggregation-events: $(AGGREGATIONEVENT_TESTS)
transaction-events: $(TRANSACTIONEVENT_TESTS)
association-events: $(ASSOCIATIONEVENT_TESTS)
with-sensor-data: $(WITHSENSORDATA_TESTS)
events-1-2: $(EVENT_TESTS_1_2)

valid: events
valid: events-1-2
#valid: object-events transformation-events aggregation-events transaction-events association-events with-sensor-data


%.event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.object-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.transformation-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.aggregation-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.transaction-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.association-event-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.withsensordata-test: %.xml
	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
#	Xalan  $< ./convert-2.0-to-1.2.xsl | xmllint --noout --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -

%.event-test-1-2: %.xml
	Xalan  $< ./convert-1.2-to-2.0.xsl | xmllint --format - | xmllint --schema ../XSD/EPCglobal-epcis-2_0.xsd -
