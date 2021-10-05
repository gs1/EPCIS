# EPCIS and CBV 2.0 Ontologies and Shape

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [EPCIS and CBV 2.0 Ontologies and Shape](#epcis-and-cbv-20-ontologies-and-shape)
    - [Ontologies](#ontologies)
    - [Ontology Checks](#ontology-checks)
    - [Property Checks](#property-checks)
    - [Conversion to JSONLD](#conversion-to-jsonld)
        - [Jena riot](#jena-riot)
        - [ttl2json](#ttl2json)
        - [jsonld-cli](#jsonld-cli)
        - [jq](#jq)
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
- Generate good JSONLD from it.
- Made ontology improvements:
  - #230 `Source` vs `Destination` class merged to `SourceOrDestination`
  - #260 disambiguate `type` to `bizTransactionType, measurementType, sourceOrDestinationType`
  - etc, etc

## Ontology Checks

#258
`ontology-check.sh` uses the "paragraph" structure of the 2 ontology Turtle files to do some basic checks and ensure that all ontology terms:
- have label,
- have definition,
- have isDefinedBy, 
- have `sw:term_status +"stable"`
- don't have `TODO`

## Property Checks

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

## Conversion to JSONLD

#238
We use some complementary tools to convert Turtle to the best possible JSON-LD:
- `CBV.ttl` to `CBV.jsonld`
- `EPCIS.ttl` to `EPCIS.jsonld`

### Jena riot

Download and install from Jena; `riot` comes as part of it

- cons: emits lists as `rdf:List` long-hand using blank nodes and `first/rest`
- cons: can't specify a custom context
- pro: generates a richer context by examining the values of each property, eg:

```json
{"@context":{"domainIncludes" : {"@id" : "http://schema.org/domainIncludes", "@type" : "@id"}},
```

This allows compact representation of properties, eg
```json
"@graph": [
  {"@id" : "epcis:action", 
   "domainIncludes" : [ "epcis:AssociationEvent", "epcis:ObjectEvent", "epcis:AggregationEvent", "epcis:TransactionEvent" ]}]}
```

I've extracted and saved this context to `EPCIS-CBV-context.jsonld`,
then added fixed `@language` to `comment` because all our definitions are in English:
```json
    "comment": {
      "@id": "http://www.w3.org/2000/01/rdf-schema#comment",
      "@language": "en"
    },
```

### ttl2json

```
npm install -g @frogcat/ttl2jsonld
```

- Pro: emits lists in short-hand, eg

```json
  {"@id":"epcis:epcClass",
   "rdfs:domain":{
    "@type":"owl:Class",
    "owl:unionOf":{"@list":[{"@id":"gs1:Product"}, {"@id":"gs1:ProductBatch"}]}}}
```

- cons: generates a simple context only using the Turtle prefixes
- cons: can't specify a custom context

### jsonld-cli

```
npm install -g jsonld-cli
```
(See [../Turtle/README.md](../Turtle/README.md) for more details.)

- Cons: can't specify input file type, thus can't convert RDF->JSONLD, see https://github.com/digitalbazaar/jsonld-cli/issues/19
- Pro: can compact JSON-LD properties while preserving compact lists
- Pro: can specify custom context
  - Cons: the context must be a file (or URL), cannot be inline
  - Uses this specific syntax for the filename, eg `jsonld compact -c file://EPCIS-CBV-context.jsonld`
  - The context cannot be embedded in the output as I want it to be (so the JSONLD is self-contained)
  - Emits the same filename as remote context in the output, which causes an error in another tool:

```
riot -syntax jsonld -formatted ttl EPCIS.jsonld
ERROR riot :: loading remote context failed: file://EPCIS-CBV-context.jsonld
```

### jq

To overcome the cons of `jsonld` described above, we need to do some advanced JSON surgery.

`jq` is the tool for that, install from https://stedolan.github.io/jq/download/ .

Then the overall pipeline to do the conversion looks like this (see `Makefile`):

```
ttl2jsonld EPCIS.ttl \
 | jsonld compact -c file://EPCIS-CBV-context.jsonld \
 | jq -S --slurpfile c EPCIS-CBV-context.jsonld '.["@context"] |= $c[0]["@context"]' \
 > EPCIS.jsonld
```

- The `jq` step slurps the context file to variable `$c`, then
  replaces the field `"@context"` (being `"file://EPCIS-CBV-context.jsonld"`)
  with its content (stripping a top-level array and dict).
- For good measure, we also use `-S` to sort the fields (keys) of each ontology term (JSONLD object) alphabetically

Then we can validate that the JSONLD is correct by converting back to formatted Turtle:

```
riot --formatted ttl EPCIS.jsonld | less
``

(but the order of ontology terms is not preserved)

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
