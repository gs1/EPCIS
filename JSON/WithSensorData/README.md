# EPCIS event data with sensorElementList in JSON / JSON-LD format

This directory has eight example files in JSON / JSON-LD  (JSON-LD with most of the  weirdness hidden in the @context header, which will eventually be remotely referenced from gs1.org)
These are intended to correspond to the XML examples in the [SensorDataExamples.xml](../../XSD/SensorDataExamples.xml) file.

It now contains updated JSON Schema or SHACL validation files with validation extended to support the new v2.0 sensor data features.

JSON-LD validation rules are expressed using W3C Shape Constraint Language (SHACL) and can be tested using https://shacl.org/playground/

JSON validation rules are expressed using JSON Schema and can be tested using https://www.jsonschemavalidator.net/ or https://json-schema-validator.herokuapp.com/

We have four examples about how we can store geo information:

- `SensorDataExample14` shows that we can express location with geographical coordinates.
- `SensorDataExample15` displays the same location, but with WGS84 default (http://www.opengis.net/def/crs/OGC/1.3/CRS84)
- `SensorDataExample16` express this as Easting, Northing in a CRS that uses these coordinate components:
https://epsg.io/27700: EPSG:27700 OSGB 1936 / British National Grid (Ordnance Survey of Great Britain).
You can see the conversion at https://epsg.io/transform#s_srs=4326&t_srs=27700&x=23.3199410&y=42.6983340,
and browse for the OGC EPSG URL at http://www.opengis.net/def/crs/EPSG/0/ (where /0/ indicates the "latest version" or version-independent URL of that CRS
- `SensorDataExample17` it's the same as `SensorDataExample14`  but Geo location is represented by using https://en.wikipedia.org/wiki/Geo_URI_scheme

 