# Test Case Requirement 53 - SensorElement

## TPId, Name
TCR-53, SensorElement
___
## Requirement purpose
This Test Case Requirement confirms the functionality of the `SensorElement` introduced as of EPCIS 2.0.
___
## Requirements tested
n.n.
___
## Pre-test conditions
* Create an EPCIS Document ('set1') with several events accommodating a `SensorElement` extension. Ensure that set1 collectively covers all `SensorElement` attributes. Ensure that at least one event has a user extension at the `SensorElement`, `SensorMetaData` and `SensorReport` level. Ensure that one event does not include a `SensorElement`. Ensure that one event conveys a sensor reading of `type` "gs1:Temperature" with a `value` expressed in `uom` "CEL".
* Create an EPCIS Document ('set2') with two events accommodating a `SensorElement` extension. In the first one, the inline attributes `dataProcessingMethod`, `deviceID`, `deviceMetaData`, `rawData`and `time`appear in the `sensorMetaData` element, while in the second one, the inline attributes are present in the `sensorReport`element.
* Document passes XML/JSON validation
    * XML/JSON(-LD) is well formed.
    * XML/JSON(-LD) is valid according to the EPCIS 2.0 schema.

## Test procedure

| Step | Step description | Expected results |
| ---- | ---------------- | ---------------- |
| 1 | Capture 'set1' of events. | Confirm that the system contains the captured events – including all `SensorElement` attributes. |
| 2 | Invoke the `poll` EPCIS method of the query interface using `SimpleEventQuery` as the `queryName` argument and one minute before step 1 test date and time as the `GE_recordTime` parameter in the `params` argument. Omit all other parameters. | All events submitted to the capture interface in step 1 are returned in the `QueryResults` instance. |
| 3 | Invoke the `poll` EPCIS method of the query interface using `SimpleEventQuery` as the `queryName` argument. In the `params` argument, insert `EXISTS_sensorElement`. Omit all other parameters. | All events submitted to the capture interface in step 1 are returned in the `QueryResults` instance, except the event without having a `SensorElement`. |
| 4 | Invoke the `poll` EPCIS method of the query interface using `SimpleEventQuery` as the `queryName` argument. In the `params` argument, insert `GE_time` and `LT_time` with a valid `time` value. Omit all other parameters. | If events submitted to the capture interface in step 1 have a `time` value within the specified time period, they are returned in the `QueryResults` instance.|
||| If the `time` value is outside the specified period, they are not returned in the `QueryResults` instance.|
| 5 | Similar to Step 4, for `GE_startTime`/ `LT_startTime` and `GE_endTime`/ `LT_endTime`, pertaining to `startTime`/ `endTime`. | Equivalent to step 4. |
| 6 | Invoke the `poll` EPCIS method of the query interface using `SimpleEventQuery` as the `queryName` argument. In the `params` argument, insert `EQ_type` with a valid `type` attribute value. Omit all other parameters. | If events submitted to the capture interface in step 1 have a matching `type` value, they are returned in the `QueryResults` instance.|
| 7 | Similar to Step 6, for `EQ_deviceID` and `deviceID`. | Equivalent to step 6. |
| 8 | Similar to Step 6, for `EQ_dataProcessingMethod` and `dataProcessingMethod`. | Equivalent to step 6. |
| 9 | Similar to Step 6, for `EQ_microorganism` and `microorganism`. | Equivalent to step 6. |
| 10 | Similar to Step 6, for `EQ_chemicalSubstance` and `chemicalSubstance`. | Equivalent to step 6. |
| 11 | Similar to Step 6, for `EQ_bizRules` and `bizRules`. | Equivalent to step 6. |
| 12 | Similar to Step 6, for `EQ_value_uom`/ `GE_value_uom`/ `LT_value_uom` and `value_uom`. | Equivalent to step 6. |
| 13 | Similar to Step 6, for `GE_minValue_uom`/ `LT_minValue_uom` and `minValue_uom`. | Equivalent to step 6. |
| 14 | Similar to Step 6, for `GE_maxValue_uom`/ `LT_maxValue_uom` and `maxValue_uom`. | Equivalent to step 6. |
| 15 | Similar to Step 6, for `GE_meanValue_uom`/ `LT_meanValue_uom` and `meanValue_uom`.| Equivalent to step 6. |
| 16 | Similar to Step 6, for `EQ_stringValue` and `stringValue`. | Equivalent to step 6. |
| 17 | Similar to Step 6, for `EQ_booleanValue` and `booleanValue`. | Equivalent to step 6. |
| 18 | Similar to Step 6, for `EQ_hexBinaryValue` and `hexBinaryValue`.| Equivalent to step 6. |
| 19 | Similar to Step 6, for `EQ_uriValue` and `uriValue`. | Equivalent to step 6. |
| 20 | Similar to Step 6, for `EQ_SENSORELEMENT_fieldname`/ `GT_SENSORELEMENT_fieldname`/ `GE_SENSORELEMENT_fieldname`/ `LT_SENSORELEMENT_fieldname`/ `LE_SENSORELEMENT_fieldname` and a valid value populating the user extension fieldname | Equivalent to step 6.|
| 21 | Similar to Step 20, for `EQ_SENSORMETADATA_fieldname`/ `GT_SENSORMETADATA_fieldname`/ `GE_SENSORMETADATA_fieldname`/ `LT_SENSORMETADATA_fieldname`/ `LE_SENSORMETADATA_fieldname` and a valid value populating the user extension fieldname | Equivalent to step 20. |
| 22 | Similar to Step 20, for `EQ_SENSORREPORT_fieldname`/ `GT_SENSORREPORT_fieldname`/ `GE_SENSORREPORT_fieldname`/  `LT_SENSORREPORT_fieldname`/ `LE_SENSORREPORT_fieldname` and a valid value populating the user extension fieldname | Equivalent to step 20.|
| 23 | Similar to Step 6, for `GE_sDev`/ `LT_sDev` and `sDev`. | Equivalent to step 6. |
| 24 | Similar to Step 6, for `GE_percRank`/ `LT_percRank` and `percRank`. | Equivalent to step 6. |
| 25 | Similar to Step 6, for `GE_percValue`/ `LT_percValue` and `percValue`. | Equivalent to step 6. |
| 26 | Invoke the `poll` EPCIS method of the query interface using `SimpleEventQuery` as the `queryName` argument. In the `params` argument, insert `EQ_type` with the `type` attribute set to "gs1:Temperature". In addition, insert `GE_value_uom` with `uom` set to "KEL" and `value` set to a value in Kelvin that is higher than the value in degrees Celsius in the event as part of set1. | The event with the corresponding temperature value, expressed in a different uom ("CEL"), which was submitted to the capture interface in step 1, is returned in the `QueryResults` instance.