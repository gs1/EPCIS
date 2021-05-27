# EPCIS event data with sensorElementList in JSON / JSON-LD format

This directory has example files in JSON / JSON-LD  (JSON-LD with most of the weirdness hidden in the `@context` header, which will eventually be remotely referenced from gs1.org).
Exmaples 1..11 are intended to correspond to the XML examples in the [SensorDataExamples.xml](../../XML/WithErrorDeclaration/SensorDataExamples.xml), and there are a few more added (examples 12, 13).

- `SensorDataExample1.jsonld`:
   3 sensor readings of Temperature, Humidity, Speed and Illuminance of a particular SGTIN at different `time`. Sensor `deviceID` is a GIAI. Includes `deviceMetadata` and `rawData` URLs
- `SensorDataExample1b.jsonld`:
   3 sensor readings, but no GTIN is mentioned, so the readings apply to the `readPoint` itself
- `SensorDataExample2.jsonld`:
   an interval reading of the same MeasurementTypes and of a particular GTIN:
   `minValue..maxValue` are reported over the interval `startTime..endTime`
- `SensorDataExample3.jsonld`:
   an interval reading, but no GTIN is mentioned, so the reading applies to the `readPoint` itself
- `SensorDataExample4.jsonld`:
   1 sensor reading of a particular quantity of a LGTIN, using 4 sensors. Includes `deviceMetadata` and `rawData` URLs for each sensor
- `SensorDataExample5.jsonld`:
   a series of 6 readings by the same sensor over different `time`
- `SensorDataExample6.jsonld`:
   an interval reading with comprehensive statistical measures (`minValue, maxValue, meanValue, sDev, percRank, percValue`) over interval `startTime, endTime`.
   Also includes a custom MeasurementType `someSensorProperty` that uses `stringValue`, and custom `furtherSensorData` with extra custom props
- `SensorDataExample7.jsonld`:
   a bunch of custom MeasurementTypes using `stringValue, booleanValue, hexBinaryValue`, and `uriValue`
- `SensorDataExample8.jsonld`:
   An interval report of Humidity, and the `Molar_concentration` (issue https://github.com/gs1/EPCIS/issues/284) of:
   - A `chemicalSubstance` (using an INCHI key URL)
   - A `microorganism` (using a NCBI taxonomy URL)
   Also an interval report of Temperature, which includes a bunch of custom props.
   Seems the good has become moldy!
- `SensorDataExample10.jsonld`:
   Reports the speed vector of a SGTIN using 3 `component`s (X, Y, Z).
   Also uses the custom prop `ex:feature` to state the speed Reading applies to the product itself.
- `SensorDataExample11.jsonld`:
   reports `EffectiveDoseRate` (issue https://github.com/gs1/EPCIS/issues/284) of two GTINs, 
   and claims `disposition: needs_replacement`.
   Seems the good has absorbed too much radiation!
- `SensorDataExample12.jsonld`:
   Uses custom prop `ex:feature` to report 3 Mass readings of a SGTIN:
   tare (`ex:packaging`), net (`ex:product`), gross (`ex:total`)
- `SensorDataExample13.jsonld`:
   Uses custom prop `ex:feature` to report the outside temperature (`ex:ambiance`) vs the temperature of the product package (`ex:outerPackage`).
   Uses `cbv:BizStep-sensor_reporting`, which is a new addition to CBV; the other examples use <urn:epcglobal:cbv:bizstep:inspecting>, which is less specific.
