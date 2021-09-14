# EPCIS and CBV 2.0 Ontologies and Shape

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [EPCIS and CBV 2.0 Ontologies and Shape](#epcis-and-cbv-20-ontologies-and-shape)
    - [Ontologies](#ontologies)
        - [Ontology Checks](#ontology-checks)
        - [Property Checks](#property-checks)
    - [RDF Shape](#rdf-shape)

<!-- markdown-toc end -->

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
`ontology-check.sh` uses the "paragraph" structure of the 2 ontology Turtle files to do some basic checks and ensure that all ontology terms:
- have label,
- have definition,
- have isDefinedBy, 
- have `sw:term_status +"stable"`
- don't have `TODO`

### Property Checks

`ontology-props.rq` makes a table of all `epcis:` props with their domains and ranges

- load EPCIS.ttl to a repo, eg https://i40kg.ontotext.com/graphdb/sparql (repo EPCIS)
- run this query and capture the table (eg as tsv)
- check against [gsheet props](https://docs.google.com/spreadsheets/d/19lseUd1kHiz48VNtrHXy6kafLTlNzS1GsaYiBqdT4UA/edit#gid=606879607)

`ontology-prop-checks.rq` checks for props with:

- mismatching `rdfs:domain` and `schema:domainIncludes`
- mismatching `rdfs:range` and `schema:rangeIncludes`
- `rdf:Property` but not `owl:ObjectProperty` or `owl:DatatypeProperty` and vice versa
- `owl:DatatypeProperty` but range is not a `xsd:` datatype
- `owl:ObjectProperty` with range not in `epcis:, cbv:` or `gs1:`
- `owl:DatatypeProperty` with range `xsd:anyURI` should be changed to `owl:ObjectProperty`, see #206

## RDF Shape

[EPCIS-SHACL.ttl](EPCIS-SHACL.ttl) is a draft SHACL shape for describing EPCIS events, initially developed by Mark Harrison then improved by Vladimir Alexiev and Martin Kotov.

To try out Shape Constraint Language (SHACL) validation, you can use this online validation tool:

https://shacl.org/playground/

- Paste the contents of EPCIS-SHACL.ttl into the 'Shapes Graph' window on the left-hand side
- Paste the contents of one of the EPCIS example files into the 'Data Graph' window on the right-hand side.
- Press both 'Update' buttons under the two  main text areas where you have just pasted in contents of files.
- If there are validation errors, they will appear in the Validation Report window (bottom-right).
- If there are no validation errors, the Validation Report window should be empty.

Further information about W3C Shape Constraint Language (SHACL)

- SHACL may be less familiar as it is a relatively new W3C technical recommendation (standard)
- The W3C SHACL standard is available at: https://www.w3.org/TR/shacl/
