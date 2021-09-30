# EPCIS XSL Transformation Tools

Support for downscaling and upscaling between versions 1.2 and 2.0

## Background

In EPCIS 2.0, the extension wrappers around known event element is going to be removed. This can be perceived as disruptive change to implementors. This tool is built to help implementors easy migration from EPCIS 1.2 to 2.0 XML document and vice-a-versa.

## Prerequisite for tool

### Install Apache Xalan-C++

- Xalan-C++ is a fast and reliable tool for XSL Transformation. To download and install visit [https://apache.github.io/xalan-c/install.html](https://apache.github.io/xalan-c/install.html)
- xmllint

### XSL Version 2.0

To allow for more concise templates and mode based processing a XSL 2.0 transformation tool is required.
Testing an Makefile is based on the [Apache Xalan](https://xalan.apache.org) XSL toolchain.

## Running and Testing

### EPCIS 2.0 to 1.2 conversion(downscaling)

run Xalan

```bash
Xalan  ../XML/Example_9.6.1-ObjectEvent-2020_06_18a.xml ./convert-2.0-to-1.2.xsl
```

run Xalan and beautify using xmllint

```bash
Xalan  ../XML/Example_9.6.1-ObjectEvent-2020_06_18a.xml ./convert-2.0-to-1.2.xsl | xmllint --format -
```

run Xalan and validate transformation to EPCIS 1.2 using xmllint

```bash
Xalan  ../XML/Example_9.6.1-ObjectEvent-2020_06_18a.xml ./convert-2.0-to-1.2.xsl | xmllint --format - | xmllint --schema ./1.2/XSD/EPCglobal-epcis-1_2.xsd -
```
### EPCIS 1.2 to 2.0 conversion(upscaling)

run Xalan

```bash
Xalan  1.2/XML/ObjectEvent.xml ./convert-1.2-to-2.0.xsl
```

run Xalan and beautify using xmllint

```bash
Xalan  1.2/XML/ObjectEvent.xml ./convert-1.2-to-2.0.xsl | xmllint --format -
```

run Xalan and validate transformation to EPCIS 1.2 using xmllint

```bash
Xalan  1.2/XML/ObjectEvent.xml ./convert-1.2-to-2.0.xsl | xmllint --format - | xmllint --schema ../XSD/EPCglobal-epcis-2_0.xsd -
```

## EPCIS Version 1.2

To support the transformation and validation toolchain, some changes to the EPCIS 1.2 XSD had to made:

* deterministic EventListType for xmllint support (sequence of choice)
* nillable quantity in QuantityElementType

### Revised EPCIS 1.2 XSD

The following XML elements should be added to existing 1.2 extensions:

* SensorElementListType
* SensorElementType
* SensorMetadataType
* SensorReportType
* SensorElementExtensionType
* PersistentDispositionType
* AssociationEventType
* AssociationEventExtensionType

**Note** The inclusion of these elements is controlled by setting the appropriate variables in [convert-2.0-to-1.2.xsl](convert-2.0-to-1.2.xsl):

* includeSensorElementList
* includePersistentDisposition
* includeAssociationEvent
