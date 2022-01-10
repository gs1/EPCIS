# EPCIS event data with sensorElementList in JSON / JSON-LD format

This directory has example files in JSON / JSON-LD. 
Most of them are derived from the XML examples in [SensorDataExamples.xml](../../XSD/SensorDataExamples.xml), but we have added some more:

- `SensorDataExample1.jsonld`: 3 sensor readings of several properties (`Temperature, Absolute Humidity, Speed, Illuminance`) 
  of a particular SGTIN at different `time` instants (here: 30 minutes apart). 
  Sensor `deviceID` is a GIAI. Includes `deviceMetadata` and `rawData` URLs
- `SensorDataExample1b.jsonld`: 3 sensor readings, but no GTIN is mentioned, so the readings apply to the `readPoint` itself
  - Also includes explicit `type` specifying `SensorElement` (not needed)
- `SensorDataExample2.jsonld`:  Based on the same data as 1, but reports `min/max/meanValue` over a time interval (a more compact form)
- `SensorDataExample3.jsonld`:  An interval reading, but no GTIN is mentioned (note that there is no object ID in the What dimension), 
  so the reading applies to the `readPoint` itself, i.e. documents the storage conditions of that location 
- `SensorDataExample4.jsonld`:  1 sensor reading of a particular quantity of a LGTIN, using 4 different sensors. 
   - Includes `deviceMetadata` and `rawData` URLs for each sensor (`rawData` vary with `sensorID` and `time`)
- `SensorDataExample5.jsonld`:  Transmits time-stamped sensor data (to be discouraged unless there is a strong reason to do so)
- `SensorDataExample6.jsonld`:  An interval reading with comprehensive statistical measures (`minValue, maxValue, meanValue, sDev, percRank, percValue`) over interval `startTime, endTime`.
   Also includes a custom MeasurementType `someSensorProperty` that uses `stringValue`, and custom `furtherSensorData` with extra custom props (user/vendor extensions)
- `SensorDataExample7.jsonld`:  Custom MeasurementTypes using non-numeric values (`stringValue, booleanValue, uriValue, hexBinaryValue`)
- `SensorDataExample8.jsonld`:  An interval report of Absolute Humidity and Temperature
   - And the concentration of:
     - A `chemicalSubstance` (using an INCHI key URL)
     - A `microorganism` (using a NCBI taxonomy URL)
  - It seems the goods have become moldy!
- `SensorDataExample9.jsonld`:  SensorElement with `ERROR_CONDITION` (further described with a URI) and an `ALARM_CONDITION` (described with boolean `true`)
- `SensorDataExample10.jsonld`: Reports the speed vector of a SGTIN using 3 `components` (`x, y, z`).
   - Also uses the custom prop `ex:feature` to state the speed Reading applies to the product itself.
- `SensorDataExample11.jsonld`: Transaction with step `inspecting` and disposition `needs_replacement` with sensor data showing `EffectiveDoseRate` measured in `P71` (millisievert per hour) of two GTINs.
  It Seems the goods have absorbed too much radiation!
- `SensorDataExample12.jsonld`: Transformation with sensorReport and user extensions in all areas where they are allowed (`procedure, machine, furtherSensorData` etc)
- `SensorDataExample13.jsonld`: Uses the custom property `ex:feature` to report the outside `Temperature` (`ex:ambiance`) vs the `Temperature` of the product package (`ex:outerPackage`).
  - Uses bizStep `sensor_reporting`, which is a new addition to CBV 2.0; the other examples use `inspecting`, which is less specific.
  - USes Web URIs (GS1 DL URIs) rather than EPC URNs
- `SensorDataExample14.jsonld`: Event conveying geographic coordinates as `latitude, longitude` (being `Angle` in `DD`) using the default Coordinate Reference System (WGS84), which does not need to be indicated
- `SensorDataExample15.jsonld`: Event conveying the same coordinates as `easting, northing` (being `Length` in `MTR`) using a Coordinate Reference System (CRS) other than WGS84
  - Namely, this uses https://epsg.io/27700 OSGB 1936 / British National Grid (Ordnance Survey of Great Britain).
  - You can see the conversion at https://epsg.io/transform#s_srs=4326&t_srs=27700&x=23.3199410&y=42.6983340,
  - You can browse for the OGC EPSG URL to use at http://www.opengis.net/def/crs/EPSG/0/ (where /0/ indicates the "latest version" or version-independent URL of that CRS)
- `SensorDataExample16.jsonld`: Event conveying the same coordinates using the [geo: URI scheme](https://en.wikipedia.org/wiki/Geo_URI_scheme) ([RFC5870](https://datatracker.ietf.org/doc/html/rfc5870)), which is a much shorter way. 
  - However, `geo:` URIs can use only two fixed CRS (see [RFC5870 section 8.3](https://datatracker.ietf.org/doc/html/rfc5870#section-8.3) and [IANA geo-uri-parameters](https://iana.org/assignments/geo-uri-parameters/geo-uri-parameters.xhtml):
    - `EPSG::4326`, which is WGS84 (2D)
    - `EPSG::4979`, which is WGS84 with altitude (3D)
  - Whereas the "long-hand" approach with `component` and `coordinateReferenceSystem` can use any EPSG or OGC coordinate system
- `SensorDataExample17.jsonld`: Uses the custom property `ex:feature` to report 3 `Mass` readings of a SGTIN:
   tare (`ex:packaging`), net (`ex:product`), gross (`ex:total`)
