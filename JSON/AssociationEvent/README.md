# EPCIS AssociationEvent Examples in JSON

These are extracted from [AssociationEvents.xml](../../XML/AssociationEvent/AssociationEvents.xml):

- `AssociationEvent-a.jsonld`:
   association for phyiscal objects such as assets and products:
   - reusable asset (GRAI, GIAI, SGTIN, CPID, ITIP, SSCC EPC URIs) to which one or more sensors are attached 
   - sensor which is mounted on/integrated into the asset 
- `AssociationEvent-b.jsonld`:
   association for physical locations (identified via SGLN EPC URIs) equipped with ambient sensors
   - location (e.g. a cold storage room) to which one or more sensors are associated
- `AssociationEvent-c.jsonld`:
   removing/unpairing sensor device from asset (`DELETE`), parallels case (a)
- `AssociationEvent-d.jsonld`:
   like case (c), but there are no child IDs at all, so we are disassembling all sub-objects
- `AssociationEvent-e.jsonld`:
   association with non-serialised IDs:
   - two quantities of particular product lots (LGTIN) are put into a returnable asset (GRAI)
- `AssociationEvent-f.jsonld`:
   has all fields of an ordinary event:
   - installing two individual assets (GIAI) and 4 products of a lot (LGTIN) in a returnable asset (GRAI)
   - also stating `bizTransaction` (a PO), transfer from a source `possessing_party` to a target `possessing_party`, and a sesnor reading
- `AssociationEvent-g.jsonld`:
   with error declaration:
   - a disassembly (`DELETE`) is declared to be wrong (`incorrect_data`)
- `AssociationEvent-h.jsonld`:
   corrective event:
   - the disassembly is expressed with correct parent (GRAI) and children (GIAIs)
