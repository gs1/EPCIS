# EPCIS Event data in JSON: Exmaples and Validation

This directory has example files in JSON / JSON-LD  (JSON with most of the  weirdness hidden in the `@context header`, which will eventually be remotely referenced from gs1.org)

- A few of the files are converted from examples in directory [../XML](../XML) using https://www.mimasu.nl/epcis/xmljson . The following corrections were needed: 
  - Change `schemaVersion` from integer `2` to string `"2.0"`, see #201
  - Remove `format`, see #267
  - change context from https://id.gs1.org/epcis-context.jsonld (its final destination) to https://gs1.github.io/EPCIS/epcis-context.jsonld (current dev version)
- `Example-TransactionEvents-2020_07_03y.xml` failed to convert, see [#276 comment](https://github.com/gs1/EPCIS/issues/276#issuecomment-843137007)

## EPCIS-JSON-Schema.json

Initially developed by Danny Haak (Nedap) and slightly modified by Mark Harrison

To try out JSON Schema validation of the examples, you can use online tools such as:

https://www.jsonschemavalidator.net/

https://jsonschemalint.com

https://json-schema-validator.herokuapp.com/

Paste the contents of EPCIS-JSON-Schema.json into the 'Schema' window (which usually appears first or to the left)
Then paste the contents of one of the EPCIS example files into the 'Data' window (which usually appears second or to the right)
Any validation errors will be reported by the tools

## Further information about JSON Schema

JSON Schema may be familiar to many Web / app developers, particularly since the Open API specification makes use of it.

Further information about JSON Schema can be found at: https://json-schema.org/

# Checking conversion of EPCIS JSON / JSON-LD examples as Linked Data

The contents of any of the EPCIS example files can also be pasted into this online tool:

https://json-ld.org/playground/

This JSON-LD playground tool perforns a basic check that the data is valid JSON-LD - although it has no awareness of our EPCIS-SHACL.ttl file.
The JSON-LD playground tool also performs conversion of JSON-LD data into other Linked Data formats such as N-Quads or Normalised (both of which are RDF Turtle format, consisting of Subject-Predicate-Object or Subject-Property-Value triples.
The JSON-LD playground tool now also includes a tabular view, as well as a visualisation as  a branching diagram.


## General note about editing in this directory

If you notice any validation errors in the examples, please contact mark.harrison@gs1.org so that we can investigate further.

Please only edit the existing JSON Schema file or SHACL file if you know what you are doing!

Please only edit the existing JSON / JSON-LD EPCIS examples if you know what you are doing 
- but feel free to take a copy or contribute additional example files.

# Examples

- `Example-Type-sourceOrDestination,measurement,bizTransaction.jsonld`: 
  shows the disambiguation of JSON element "type" to different RDF properties:
  - `epcis:bizTransactionType` (from `epcis:BizTransaction` to `cbv:BTT`)
  - `epcis:measurementType` (from `epcis:SensorReport` to `gs1:MeasuremenType`)
  - `epcis:sourceOrDestinationType` (from `epcis:SourceOrDestination` to `cbv:SDT`)
  - TODO: has the EPCIS context embedded inline (because of context deployment delays), must be changed to a link

