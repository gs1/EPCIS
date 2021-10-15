Events that involve `ErrorDeclaration` and `correctiveEventID`:

- `ErrorDeclarationAndCorrectiveEvent.jsonld`: 
  transformation event (commissioning)
- `Example_9.6.1-ObjectEvent-with-error-declaration.jsonld`
  - TODO: this uses `urn:uuid:` which is not recommended for `eventID`, the `correctiveEvents` are not shown, and has a disconnected `receiving` event
- `Example-ObjectEvent-with-reused-source-destination.jsonld`:
  - The only difference is a correction from 200 KGM to 400 KGM
  - Shows how you can use "id" to reuse definitions of "source/destination+type", so that you can save on triples in RDF
  - Eg `http://example.org/gln/0614141.00001.0/type/own` is the ID (URL) of SGLN `urn:epc:id:sgln:0614141.00001.0` with type `owning_party`
  - The same technique is applicable globally, not just in pairs of erroneous-corrective events
