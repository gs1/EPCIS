# EPCIS 2.0 XSD validation

The main EPCIS v2.0 XSD draft file is EPCglobal-epcis-2_0.xsd , which currently imports other EPCIS v1.2 XSD files which have not been altered.
Also present in this directory is an XML instance file, SensorDataExamples.xml  which provides examples of EPCIS 2.0 event data including <sensorElementList> elements.
Thanks to @RalphTro (Ralph Troeger) for preparing the XML instance file.  Mark Harrison made a minor modification to change the attribute averagValue to mean
since there are multiple kinds of average (mean, mode, median) and if we're being really pedantic, we should probably specify that we mean the arithmetic mean rather than the geometric mean.

At present, only limited testing has been done by Mark Harrison, using Oxygen XML Editor on Mac OS.
We would all appreciate additional eyes taking a critical look at the draft EPCglobal-epcis-2_0.xsd and providing feedback.
We need to check that all appropriate extension points from v1.2 are still supported and that the new elements introduced in v2.0 (for sensor data) also support extension.

