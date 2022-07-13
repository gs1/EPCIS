# EPCIS JSON / JSON-LD Examples

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [EPCIS JSON / JSON-LD Examples](#epcis-json--json-ld-examples)
- [Validation of EPCIS event data in JSON / JSON-LD using JSON Schema and SHACL](#validation-of-epcis-event-data-in-json--json-ld-using-json-schema-and-shacl)
    - [EPCIS-JSON-Schema.json](#epcis-json-schemajson)
    - [EPCIS-SHACL.ttl](#epcis-shaclttl)
- [Conversion of EPCIS JSON / JSON-LD examples to RDF Linked Data](#conversion-of-epcis-json--json-ld-examples-to-rdf-linked-data)
- [Further information about JSON Schema](#further-information-about-json-schema)
- [Further information about W3C Shape Constraint Language (SHACL)](#further-information-about-w3c-shape-constraint-language-shacl)
- [General note about editing in this directory](#general-note-about-editing-in-this-directory)
- [List of Examples](#list-of-examples)

<!-- markdown-toc end -->

# Validation of EPCIS event data in JSON / JSON-LD using JSON Schema and SHACL

This directory has example files in JSON / JSON-LD  (JSON-LD with most of the  weirdness hidden in the @context header, which will eventually be remotely referenced from gs1.org)

Sibling directories also contain validation files:

## EPCIS-JSON-Schema.json

Initially developed by Danny Haak (Nedap), then modified by Mark Harrison,  Jose Montera Cantera Fonseca, Bhavesh Shah, Shalika Singh.

To try out JSON Schema validation of the examples, you can use online tools such as:

- https://www.jsonschemavalidator.net/
- https://jsonschemalint.com
- https://json-schema-validator.herokuapp.com/

Paste the contents of EPCIS-JSON-Schema.json into the 'Schema' window (which usually appears first or to the left)
Then paste the contents of one of the EPCIS example files into the 'Data' window (which usually appears second or to the right)
Any validation errors will be reported by the tools

## EPCIS-SHACL.ttl

Initially developed by Mark Harrison, then modified by Vladimir Alexiev and Martin Kotov.

To try out Shape Constraint Language (SHACL) validation, you can use this online validation tool:

- https://shacl.org/playground/

Paste the contents of EPCIS-SHACL.ttl into the 'Shapes Graph' window on the left-hand side
Paste the contents of one of the EPCIS example files into the 'Data Graph' window on the right-hand side.
Press both 'Update' buttons under the two  main text areas where you have just pasted in contents of files.

If there are validation errors, they will appear in the Validation Report window (bottom-right).
If there are no validation errors, the Validation Report window should be empty.

# Conversion of EPCIS JSON / JSON-LD examples to RDF Linked Data

The contents of any of the EPCIS example files can also be pasted into this online tool:

https://json-ld.org/playground/

This JSON-LD playground tool:

- Performs a basic check that the data is valid JSON-LD - although it has no awareness of our EPCIS-SHACL.ttl file.
- Converts between different JSON-LD renditions, eg Normalised, Compacted, Expanded
- Performs conversion of JSON-LD data into other RDF (Linked Data formats),
  such as N-Quads (consisting of Subject-Predicate-Object-Graph quads)
- Now also includes a tabular view, as well as a visualisation as  a branching diagram.

# Further information about JSON Schema

JSON Schema may be familiar to many Web / app developers, particularly since the Open API specification makes use of it.

Further information about JSON Schema can be found at: https://json-schema.org/

# Further information about W3C Shape Constraint Language (SHACL)

Shape Constraint Language (SHACL) may be less familiar, even though it is a relatively new W3C technical recommendation (standard)

The W3C SHACL standard is available at: https://www.w3.org/TR/shacl/

# General note about editing in this directory

If you notice any validation errors in the examples, please contact mark.harrison@gs1.org so that we can investigate further.

Please only edit the existing JSON Schema file or SHACL file if you know what you are doing!

Please only edit the existing JSON / JSON-LD EPCIS examples if you know what you are doing 
- but feel free to take a copy or contribute additional example files.

# List of Examples

Examples were derived from XML examples, then significantly added and commented by Vladmir Alexiev, Greg Rowe, Craig Alan Repec and other WG members

- `Example-TransactionEvents-2020_07_03y.jsonld`: custom transactions (summarising discharge from a hospital, passage of rail cars)
- `Example-Type-sourceOrDestination,measurement,bizTransaction.jsonld`: shows the disambiguation of JSON field `type` to different RDF properties:
  - `epcis:bizTransactionType` (from `epcis:BizTransaction` to `cbv:BTT`)
  - `epcis:measurementType` (from `epcis:SensorReport` to `gs1:MeasurementType`)
  - `epcis:sourceOrDestinationType` (from `epcis:SourceOrDestination` to `cbv:SDT`)
- `Example_9.6.1-ObjectEvent.jsonld`: object event involving businessTransactions
- `Example_9.6.1-with-comment.jsonld`: object event with custom field and a comment
- `Example_9.6.2-ObjectEvent.jsonld`: object event involving source and destination
- `Example_9.6.3-AggregationEvent.jsonld`: aggregation events involving childEPCs and childQuantityLists
- `Example_9.6.4-TransformationEvent.jsonld`: transformation event with `ilmd` (Instance/Lot Master Data)
- `PersistentDisposition-example.jsonld`: object event involving the change of persistent disposition from `completeness_inferred` to `completeness_verified`

Further explanations about individual examples are found in sub-directories
