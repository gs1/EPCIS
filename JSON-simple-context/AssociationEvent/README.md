
Association events in JSON/JSON-LD  extracted from [AssociationEvents.xml](../../XML/AssociationEvent/AssociationEvents.xml):

- `AssociationEvent-a.jsonld`: `assembling`: association for physical objects such as assets and products:
   - reusable asset (GRAI, GIAI, SGTIN, CPID, ITIP, SSCC EPC URIs) to which one or more sensors are attached 
   - sensor which is mounted on/integrated into the asset 
- `AssociationEvent-b.jsonld`: `installing`: association for physical locations (identified via SGLN EPC URIs) equipped with ambient sensors
   - location (e.g. a cold storage room) to which one or more sensors are associated
- `AssociationEvent-c.jsonld`: `removing` (unpairing) sensor device from asset (`DELETE`), parallels case `a`
- `AssociationEvent-d.jsonld`: `disassembling`: like case `c`, but there are no child IDs at all, so we are disassembling all sub-objects
- `AssociationEvent-e.jsonld`: `assembling` with non-serialised IDs:
   - two childQuantities of particular product lots (LGTIN) are put into a returnable asset (GRAI)
- `AssociationEvent-f.jsonld`: has all fields of an ordinary event:
   - installing two individual assets (GIAI) and 4 products of a lot (LGTIN) in a returnable asset (GRAI)
   - also stating `bizTransaction` (a PO), transfer from a source `possessing_party` to a target `possessing_party`, and a sensor reading of `AbsoluteHumidity`
- `AssociationEvent-g.jsonld`: `disassembling` that is declared to be wrong with an ErrorDeclaration with `reason`: `incorrect_data` and has a `correctiveEventID`
- `AssociationEvent-h.jsonld`: `disassembling` expressed with correct parent (GRAI) and children (GIAIs) (correction of the event in the previous example)
