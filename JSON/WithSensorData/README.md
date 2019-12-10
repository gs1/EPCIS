# EPCIS event data with sensorElementList in JSON / JSON-LD format

This directory has eight example files in JSON / JSON-LD  (JSON-LD with most of the  weirdness hidden in the @context header, which will eventually be remotely referenced from gs1.org)
These are intended to correspond to the XML examples in the [SensorDataExamples.xml](../../XSD/SensorDataExamples.xml) file.

It now contains updated JSON Schema or SHACL validation files with validation extended to support the new v2.0 sensor data features.

JSON-LD validation rules are expressed using W3C Shape Constraint Language (SHACL) and can be tested using https://shacl.org/playground/

JSON validation rules are expressed using JSON Schema and can be tested using https://www.jsonschemavalidator.net/ or https://json-schema-validator.herokuapp.com/
