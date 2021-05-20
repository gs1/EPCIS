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

- Downloaded from https://ns.mh1.eu/epcis/ and https://ns.mh1.eu/cbv/ (View Source and then save the JSON-LD fragments)
- Converted to Turtle using the same process described in [../Turtle](../Turtle), the sorting in a better way
  - WARNING: `make` overwrites the Turtle files from JSONLD files. 
    If in the future we decide to use Turtle as the master source, this needs to change.

These are draft and subject to change

## RDF Shape

[EPCIS-SHACL.ttl](EPCIS-SHACL.ttl) is a draft SHACL shape for describing EPCIS events, initially developed by Mark Harrison

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
