# Validation of EPCIS event data in JSON / JSON-LD using JSON Schema and SHACL

This directory has four example files in JSON / JSON-LD  (JSON-LD with most of the  weirdness hidden in the @context header, which will eventually be remotely referenced from gs1.org)

The directory also contains two validation files:

## EPCIS-JSON-Schema.json

Initially developed by Danny Haak (Nedap) and slightly modified by Mark Harrison

To try out JSON Schema validation of the examples, you can use online tools such as:

https://www.jsonschemavalidator.net/
https://jsonschemalint.com
https://json-schema-validator.herokuapp.com/

Paste the contents of EPCIS-JSON-Schema.json into the 'Schema' window (which usually appears first or to the left)
Then paste the contents of one of the EPCIS example files into the 'Data' window (which usually appears second or to the right)
Any validation errors will be reported by the tools

## EPCIS-SHACL.ttl

Initially developed by Mark Harrison

To try out Shape Constraint Language (SHACL) validation, you can use this online validation tool:

https://shacl.org/playground/

Paste the contents of EPCIS-SHACL.ttl into the 'Shapes Graph' window on the left-hand side
Paste the contents of one of the EPCIS example files into the 'Data Graph' window on the right-hand side.
Press both 'Update' buttons under the two  main text areas where you have just pasted in contents of files.

If there are validation errors, they will appear in the Validation Report window (bottom-right).
If there are no validation errors, the Validation Report window should be empty.
