# EPCIS and CBV 2.0 Ontologies and Shape

## Ontologies

These are draft and subject to change

- Downloaded from https://ns.mh1.eu/epcis/ and https://ns.mh1.eu/cbv/ (View Source and then save the JSON-LD fragments)
- Converted to Turtle using the same process described in [../Turtle](../Turtle), then sorting in a better way
  - WARNING: `make` overwrites the Turtle files from JSONLD files. 
    If in the future we decide to use Turtle as the master source, this needs to change.
- Adopted Turtle as master ontology format
  - Keep it organized in sections (Classes, Properties) and sorted by "paragraph" in each section
- TODO generate good JSONLD from it.
- Made ontology improvements:
  - #230 `Source` vs `Destination` class merged to `SourceOrDestination`
  - #260 disambiguate `type` to `bizTransactionType, measurementType, sourceOrDestinationType`

### Ontology Checks

#258
`check-ontology.sh` uses the "paragraph" structure of the 2 ontology Turtle files to do some basic checks and ensure that all ontology terms:
- have label,
- have definition,
- have isDefinedBy, 
- don't have TODO

## RDF Shape

- [EPCIS-SHACL.ttl](EPCIS-SHACL.ttl) is a draft SHACL shape for describing EPCIS events

