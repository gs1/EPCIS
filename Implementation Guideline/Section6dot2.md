# 6.2 EPCIS Queries - additions to table 6.2

| Business Information Need | Relevant EPCIS Events | EPCIS Query Criteria |
| ------------------------- | --------------------- | -------------------- |
| Identify all logistics units of a given organisation that were transported at a temperature of 15.5 ° CEL or more | All EPCIS events with business step transporting that have a `sensorReport` element of type `gs1:Temperature`, which are populated with SSCCs featuring a specific GCP, with a corresponding quantitative value equal to or greater than 15.5 `CEL` | `EQ_bizStep`: `urn:epcglobal:cbv:bizstep:transporting` <br> `MATCH_epc`: SSCC ID Pattern <br> `GE_value_CEL`: 15.5 |