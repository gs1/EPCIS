# EPCIS event data with sensorElementList in JSON / JSON-LD format

This directory has example files in JSON / JSON-LD. 
Most of them are derived from the XML examples in [SensorDataExamples.xml](../../XSD/SensorDataExamples.xml), but we have added some more:

- `SensorDataExample1.jsonld`:  Captures various sensor properties (`Temperature, Humidity, Speed, Illuminance` at given time instants (here: 30 minutes apart)
- `SensorDataExample1b.jsonld`: Same but also includes explicit `isA` specifying `SensorElement` (not needed)
- `SensorDataExample2.jsonld`:  Based on the same data as 1, but reports `min/max/meanValue` over a time interval (a more compact form)
- `SensorDataExample3.jsonld`:  Documents the storage conditions (`Temperature, Humidity`) of a given location (note that there is no object ID in the What dimension)
- `SensorDataExample4.jsonld`:  Includes some metadata in `sensorReport` (in case sensor data originates from various sensor devices)
- `SensorDataExample5.jsonld`:  Transmits time-stamped sensor data (to be discouraged unless there is a strong reason to do so)
- `SensorDataExample6.jsonld`:  Uses user/vendor extensions
- `SensorDataExample7.jsonld`:  Accommodates non-numeric values (`stringValue, uriValue, hexBinaryValue`)
- `SensorDataExample8.jsonld`:  A variety of readings including concentration of `chemicalSubstance` and `microorganism`
- `SensorDataExample9.jsonld`:  SensorElement with `ERROR_CONDITION` (further described with a URI) and an `ALARM_CONDITION` (described with boolean `true`)
- `SensorDataExample10.jsonld`: Sensor data (`Speed`) expressed as a multi-dimensional vector
- `SensorDataExample11.jsonld`: Transaction with step `inspecting` and disposition `needs_replacement` with sensor data showing `EffectiveDoseRate` measured in `P71` = millisievert per hour
- `SensorDataExample12.jsonld`: Transformation with sensorReport and user extensions in all areas where they are allowed (`procedure, machine, furtherSensorData` etc)
- `SensorDataExample13.jsonld`: Event with Web URIs/GS1 DL URIs, which illustrates the `ex:feature` property (a user extension): `Temperature` of `ambiance` vs `outerPackage`
- `SensorDataExample14.jsonld`: Event conveying geographic coordinates as `Latitude, Longitude` (being `Angle` in `DD`) using the default Coordinate Reference System (WGS84), which does not need to be indicated
- `SensorDataExample15.jsonld`: Event conveying the same coordinates as `Easting, Northing` (being `Length` in `MTR`) using a Coordinate Reference System (CRS) other than WGS84
- `SensorDataExample16.jsonld`: Event conveying the same coordinates using the [geo: URI scheme](https://en.wikipedia.org/wiki/Geo_URI_scheme) ([RFC5870](https://datatracker.ietf.org/doc/html/rfc5870)), which is a much shorter way. 
  - However, `geo:` URIs can use only two fixed CRS (see [RFC5870 section 8.3](https://datatracker.ietf.org/doc/html/rfc5870#section-8.3) and [IANA geo-uri-parameters](https://iana.org/assignments/geo-uri-parameters/geo-uri-parameters.xhtml):
    - `EPSG::4326`, which is WGS84 (2D)
    - `EPSG::4979`, which is WGS84 with altitude (3D)
  - Whereas the "long-hand" approach with `component` and `coordinateReferenceSystem` can use any EPSG or OGC coordinate system
