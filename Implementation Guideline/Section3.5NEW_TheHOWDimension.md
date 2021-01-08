# 3.5 The How dimension

The How dimension of an EPCIS event - optional in its entirety - can accommodate a variety of sensor data pertaining to the EPCIS event it is part of.

Thereby, the term 'sensor data' covers a huge set of conceivable contents. The developed framework allows for ample flexibility: organisations are not only able to transmit physical measurements (e.g. temperature values expressed in degree Celsius or Kelvin), but also output values of smart sensor devices, which abstract from raw sensor data. For instance, instead of a specific weight value, a simple smart sensor device would transmit a meaningful value such as 'too heavy' or 'incomplete'. Moreover, it is also possible to capture the concentration of microorganisms (e.g. bacteria) or chemical substances. In addition, there is also a selected set of statistical measures (e.g. mean value) that can be included.

All data related to the How dimension is part of the `sensorElememt` field. The latter has two child elements:
- one optional `sensorMetaData` element 
- at least one `sensorReport` element

Both contain a set of pertinent attributes, which can be outlined as follows:

## Sensor meta data fields

| Context | Attribute | Meaning |
| --- | ------------ | -- |
| time | `time` | Time of observation |
| | `startTime` | Earliest time of observation period |
| | `endTime` | Most recent time of observation period |
| source | `deviceID` | Device from which data originates |
| | `deviceMetaData` | Location of document specifying device meta data |
| | `rawData` | Location of raw sensor data |
| | `dataProcessingMethod` | Location of document specifying data processing method |
| | `bizRules` | Location of document specifying business rules |

## Sensor report fields

| Context | Attribute | Meaning |
| --- | ------------ | -- |
| time | `time` | Time of observation |
| source | `deviceID` | Device from which data originates |
| | `deviceMetaData` | Location of document specifying device meta data |
| | `rawData` | Location of raw sensor data |
| | `dataProcessingMethod` | Location of document specifying data processing method |
| type | `type` | Property identifier |
| | `microorganism` | Microorganism species identifier |
| | `chemicalSubstance` | Chemical substance identifier |
| value | `value` | Quantitative (float) value of a property |
| | `component` | Dimension indicator of a vector value |
| | `stringValue` | String value of a property |
| | `booleanValue` | Boolean value of a property |
| | `hexBinaryValue` | HexBinary value of a property |
| | `uriValue` | URI value of a property |
| | `uom` | Unit of measure of specified property values |
| statistics | `minValue` | Minimum quantitative value of a property |
| | `maxValue` | Maximum quantitative value of a property |
| | `meanValue` | Arithmetic mean of quantitative property values |
| | `sDev` | Standard deviation of quantitative property values |
| | `percRank` | Percentile rank |
| | `percValue` | Percentile value |