# EPCIS 2.0 XSD validation

The main EPCIS v2.0 XSD draft file is [EPCglobal-epcis-2_0.xsd](EPCglobal-epcis-2_0.xsd) , which currently imports other EPCIS v1.2 XSD files which have not been altered.
Also present in this directory is an XML instance file, [SensorDataExamples.xml](../XML/WithSensorData/SensorDataExamples.xml)  which provides examples of EPCIS 2.0 event data including <sensorElementList> elements.
Thanks to @RalphTro (Ralph Troeger) for preparing the XML instance file.  Mark Harrison made a minor modification to change the attribute averagValue to mean
since there are multiple kinds of average (mean, mode, median) and if we're being really pedantic, we should probably specify that we mean the arithmetic mean rather than the geometric mean.

At present, only limited testing has been done by Mark Harrison, using Oxygen XML Editor on Mac OS.
We would all appreciate additional eyes taking a critical look at the draft [EPCglobal-epcis-2_0.xsd](EPCglobal-epcis-2_0.xsd) and providing feedback.
We need to check that all appropriate extension points from v1.2 are still supported and that the new elements introduced in v2.0 (for sensor data) also support extension.

## Change Logs

### Fixed 

- The non-deterministic behaviour of EPCIS 1.2 XSD has been fixed. EPCIS 2.0 XSD has a deterministic behavior.

### Changed

- The EPCIS 2.0 XSD gets rid of any unnecessary or duplicated extension tags. In that process Transformation Event is placed at the same level as other legacy EPCIS Events(i.e., ObjectEvent or Aggregation Events)

### Added

- The EPCIS 2.0 XSD includes all the newness in terms of feature that has been introduced in EPCIS 2.0(i.e., inclusion of sensor element and persistent disposition attribute and the addition of all new AssociationEvent in EventList).

## Test Coverage

Validated XML files against EPCIS 2.0 XSD are placed under XML directory under the root of the project. If you want to validate  your own examples then you can simply add more events and use Makefile to validate automatically.


