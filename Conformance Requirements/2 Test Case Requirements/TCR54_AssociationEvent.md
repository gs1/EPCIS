# Test Case Requirement 54 - AssociationEvent

## TPId, Name
TCR-54, Association Event
___
## Requirement purpose
This Test Case Requirement confirms the capture interface will accept events of type `AssociationEvent` introduced as of EPCIS 2.0.
___
## Requirements tested
n.n.
___
## Pre-test conditions
* Create an EPCIS Document with several Association Events. Ensure that at least one event has a `parentID` populated with a physical location identifier (e.g. an SGLN EPC URI). Ensure that at least one event omits the `parentID` field when `action` is either `ADD` or `DELETE`. Ensure that at least one event has an empty `childEPCs`and `childQuantityList` element when `action` is either `ADD` or `OBSERVE`.
* Document passes XML/JSON validation
    * XML/JSON(-LD) is well formed.
    * XML/JSON(-LD) is valid according to the EPCIS 2.0 schema.

## Test procedure

| Step | Step description | Expected results |
| ---- | ---------------- | ---------------- |
| 1 | Create an EPCIS document accommodating a set of Association Events considering the above pre-test conditions. | Verify that the created document is in a capture-acceptable form (EPCISDocument or EPCISQueryResponse meeting requirements) and that the document complies with the EPCIS 2.0 requirements. |
| 2 | Capture an EPCIS document with an `AssociationEvent` where `parentID`  is populated with a physical location identifier. | The capture interface accepts the EPCIS document. Confirm that the system contains the captured event. |
| 3 | Capture an EPCIS document with an `AssociationEvent` where `action` is either `ADD` or `DELETE` and the `parentID` field is omitted. | The capture interface does not accept the EPCIS document. |
| 4 | Capture an EPCIS document with an `AssociationEvent` where `action` is either `ADD` or `OBSERVE` and both `childEPCs` and `childQuantityList` are omitted. | The capture interface does not accept the EPCIS document. |