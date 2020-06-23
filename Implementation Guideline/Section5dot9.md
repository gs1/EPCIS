# 5.9 Sensor-based quality data 

To improve e.g. patient safety, consumer protection, supply chain visibility and food safety, there is a growing need to capture and share sensor data. The Sensor Element, introduced as of EPCIS 2.0, allows organisations to provide trading partners such data in a standardised manner – for instance, if they want to prove that goods never exceeded a specific sensor property value during the time they had custody of these items.

It is of paramount importance that EPCIS is not meant to transmit raw sensor data dumps. Rather, its added value consists in the ability to provide applications business-oriented, aggregated sensor data. For example, retailers typically are just interested in knowing whether they can put received goods on their shelves or not – in other words, if products were handled within an agreed temperature range. They are not concerned about discrete temperature values at specific timestamps. Therefore, even though the EPCIS data model would *theoretically* allow to accommodate time-stamped sensor data, organisations should model EPCIS events transmitting sensor data very carefully. (Note: even if there is a need to access the original sensor data underlying a given EPCIS event, organisations can use the standard field rawData to point to that data without having to blow up the EPCIS event itself.)

## Example 1: Control/prove temperature compliance

Suppose an organisation that trades temperature-sensitive goods (e.g. cheese, wine, pharmaceutical products) has set up the necessary hardware to capture both the identities as well as the temperature values of items when the latter are in the company's custody.

Now, if this organisation wants to provide that data to internal or external stakeholders (e.g. the company's quality assurance department or trading partners that wish to ascertain if specific items were handled/transported properly), it makes a lot of sense to use a standard format from the outset.

Typical critical tracing events accommodating sensor data can easily be modelled as EPCIS events. Following the usual approach, a visibility data matrix could look like this (the table focusses on the relevant excerpt of the overall chain of events):

| Dim | Data Element | V1 | V2 | V3 | V4 |
| --- | ------------ | -- | -- | -- | -- |
|  | Description | Move logistics unit to interim storage room | Move logistics into cold storage room | Move logistics out of cold storage room | Daily sensor reporting of cold storage room |
|  | Event Type | Object Event | Object Event | Object Event | Object Event |
|  | Action | OBSERVE | OBSERVE | OBSERVE | OBSERVE |
| When | `eventTime` | 15 June, 08:00 am | 15 June, 08:15 am | 15 June, 05:45 pm | 15 June, 11:59 pm |
| What | `epcList` | SSCC of logistics unit | SSCC of logistics unit | SSCC of logistics unit | |
| Where | `readPoint` | GLN of receiving area | GLN of interim storage room | GLN of cold storage room | GLN of cold storage room |
| | `bizLocation` | GLN of interim storage room | GLN of cold storage room | GLN of shipping area | |
| Why | `bizStep` | `Storing (CBV)` | `Storing (CBV)` | `Storing (CBV)` | `Sensor reporting (CBV)` |
| How | `sensorElement` |
| | `sensorReport` |
| | `startTime` | 15 June 07:55 am | 15 June 08:10 am | 15 June 05:35 pm | 14 June 11:59 pm |
| | `endTime` | 15 June 07:59 am | 15 June 08:14 am | 15 June 05:55 pm | 15 June 11:59 pm |
| | `type` | `Temperature (CBV`) | `Temperature (CBV)` | `Temperature (CBV)` | `Temperature (CBV)` |
| | `minValue` | 12 | 12.1 | 9.2 | 9.1 |
| | `maxValue` | 12.1 | 12.2 | 9.2 | 9.4 |
| | `uom` | `CEL` | `CEL` | `CEL` | `CEL` |

On this basis, the organisation has an unbroken chain of events documenting the condition of an individual item, beginning from when it was relocated from the receiving area to an interim storage room (V1), when it was moved in and out of the cold storage room (V2 and V3), and while it was residing in the cold storage room (V4).

As to V4, note that as of as of EPCIS/CBV 2.0, a CBV-compliant EPCIS event is allowed to have an empty WHAT dimension, if a non-empty Sensor Element is present. In such a case, the object of observation is the physical location indicated in the WHERE dimension (i.e. populating either readPoint or bizLocation). Also, V4 leverages bizStep 'sensor_reporting' which is an appropriate choice when no actual business process step is ongoing.

With regard to designing the HOW dimension, the organisation has ample flexibility. For instance, they *could* have included a pointer to the underlying raw sensor data (rawData), indicated the ID of the respective sensor devices (deviceID) or inserted a reference to the meta data of a given sensor device (deviceMetaData). For simplicity, we assume that the business need consists in controlling that the ambient temperature did not exceed a specific minimum or maximum value. For this purpose, the company can get by with a very concise set of attributes: the start and end time of a related sensor reading as well as the highest and lowermost temperature value within that period, expressed in degree Celsius.

In this context, the company could also have chosen another appropriate unit of measure listed in UN/ECE Recommendation 20 (i.e. Kelvin, degrees Fahrenheit or Rankine).

For convenience and to ease implementation, GS1 provides an Open Source library to automatically convert between any quantitative value of a given property type (e.g. temperature). The library is available at
https://github.com/gs1/UnitConverterUNECERec20.  

## Example 2: Exception notification

Presume a company wishes to trigger processes (adjust settings of an environmental control system, alert an employee, etc.) when a certain condition (e.g. a temperature excursion) occurs.

Pursuing the example from the previous section, a company may want to trigger an alert message to the warehouse manager in case the temperature in the cold storage room falls below or exceeds a predefined threshold (e.g. < 8 ° CEL and > 15 ° CEL). The company also wants to store that information in their Quality Management System as well as provide that to an external solution provider which is in charge of maintaining the cold storage room's technical infrastructure.

In such a setting, the 'alert' EPCIS event could be modelled as follows:

| Dim | Data Element | V1 |
| --- | ------------ | -- |
|  | Description | Exception notification event for temperature exceeding |
|  | Event Type | Object Event |
|  | Action | OBSERVE |
| When | `eventTime` | 23 June, 11:19 am |
| Where | `readPoint` | GLN of cold storage room |
| Why | `bizStep` | `Sensor reporting (CBV)` |
| How | `sensorElement` |
| | `sensorMetaData` |
| | `bizRules` | https://example.org/253/4012345000054987
| | `sensorReport` |
| | `type` | `Temperature (CBV`) |
| | `value` | 15.1 |
| | `uom` | `CEL` |
| | `sensorReport` |
| | `type` | `AlarmCondition (CBV`) |
| | `uriValue` | https://example.com/alarmCodes/temperatureExceeded |

In contrast to the previous example, the event accommodates the (optional) `sensorMetaData` field, which in turn contains a reference (the Web URI is a valid GS1 Digital Link URI leveraging a custom (here: "example.com) domain, `253` denotes the GS1 Application Identifier for the Global Document Type Identifier) to an electronic document including the business rule(s) upon which the EPCIS event was captured. The company may decide to also insert additional attributes such as `deviceID` or `deviceMetaData` into this element, if applicable.

Apart from the actual temperature value (exceeding the predefined threshold), the `sensorElement` contains a second `sensorReport` element accommodating an alarm value, expressed as a URI. The latter consists of a custom value - a future GS1 working group may define standard vocabulary for alarm/error code values for this application domain.

## Example 3: Condition monitoring and tracking of intermodal transports

Nowadays, goods are often transported through several modes of transport, e.g. in sea containers, trucks or railway carriages. If a companies wants to control whether their products are properly transported and which areas a container vessel traversed, it is advisable if the respective logistics/transport service providers supply the corresponding visibility event data in a standardised manner.

For instance, if an organisation is interested to ascertain that their products were not exposed to a certain level of air humidity during transport as well as the approximate sea transport route, the following EPCIS event sequence would make sense:

| Dim | Data Element | V1 | V2 | V3 | V4 | V5 | V6 | V7 | V8 | V9 | V10 |
| --- | ------------ | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- |
|  | Description | Pack products into logistics unit | Load logistics unit onto sea container | Load sea containers onto truck | Truck arrival at port | Unload sea containers from truck | Load sea containers onto vessel | Vessel departure from port | Daily sensor reporting of sea container |Daily vessel report with 4-hourly geo positions | Daily sensor reporting of sea container |
|  | Event Type | Aggregation Event | Aggregation Event | Aggregation Event | Object Event | Aggregation Event | Aggregation Event | Object Event | Object Event | Object Event | Object Event |
|  | Action | ADD | ADD | ADD | OBSERVE | DELETE | ADD | OBSERVE | OBSERVE | OBSERVE | OBSERVE |
| When | `eventTime` | 24 June, 08:00 am | 24 June, 09:15 am | 24 June, 09:45 am | 24 June, 02:20 pm | 24 June, 02:55 pm | 24 June, 05:11 pm | 25 June, 04:00 am | 24 June, 11:59 pm | 25 June, 11:59 pm | 25 June, 11:59 pm |
| What | `epcList` | | | | GIAI of the truck |  |  | IMO Vessel Number of ship | BIC of sea container | IMO Vessel Number of ship | BIC of sea container |
|  | `parentID` | SSCC of logistics unit | BIC of sea container | GIAI of the truck  |  | GIAI of the truck | IMO Vessel Number of ship |  |  |  |  |  |
|  | `childEPCs` | SGTINs of products | SSCC of logistics unit | BIC of sea container |  | BIC of sea container | BIC of sea container |  |  |  |  |
| Where | `readPoint` | GLN of warehouse | GLN of warehouse | GLN of warehouse | GLN of port | GLN of port | GLN of port | GLN of port |  |  |
| Why | `bizStep` | `Packing (CBV)` | `Loading (CBV)` | `Loading (CBV)` | `Arriving (CBV)` | `Unloading (CBV)` | `Loading (CBV)` | `Departing (CBV)`| `Sensor reporting (CBV)` |  `Sensor reporting (CBV)` | `Sensor reporting (CBV)` |
| How | `sensorElement` |
|  |  `sensorMetaData` |
| | `startTime` |  |  |  |  |  |  |  | 23 June 11:59 pm |  | 24 June 11:59 pm |
| | `endTime` |  |  |  |  |  |  |  | 24 June 11:59 pm |  | 25 June 11:59 pm |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  | `Temperature (CBV)` |  | `Temperature (CBV)` |
| | `minValue` |  |  |  |  |  |  |  | 8.1 |  | 5.6 |
| | `maxValue` |  |  |  |  |  |  |  | 21.8 | | 14.9 |
| | `uom` |  |  |  |  |  |  |  | `CEL` |  | `CEL` |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  | `Humidity (CBV)` |  | `Humidity (CBV)` |
| | `minValue` |  |  |  |  |  |  |  | 6.1 |  | 4.6 |
| | `maxValue` |  |  |  |  |  |  |  | 8.2 | | 3.3 |
| | `uom` |  |  |  |  |  |  |  | `A93` |  | `A93` |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 02:00 am |  |
| | `rawData` |  |  |  |  |  |  |  |  | https://example.org/8004/401234599999 |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 53.553747 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 8.562372 |  |  |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 06:00 am |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 53.882318 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 8.099310 |  |  |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 10:00 am |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 54.172892 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 7.094428 |  |  |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 02:00 pm |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 54.389794 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 5.753072 |  |  |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 06:00 pm |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 54.790116 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 3.407863 |  |  |
| | `sensorElement` |
| | `sensorMetaData` |
| | `time` |  |  |  |  |  |  |  |  | 25 June 10:00 pm |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Latitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 56.196056 |  |  |
| | `sensorReport` |
| | `type` |  |  |  |  |  |  |  |  | `Longitude (CBV)` |  |  |
| | `stringValue` |  |  |  |  |  |  |  |  | 1.490934 |  |  |
  
Note that though further appropriate EPCIS events (e.g. shipping, receiving) were omitted for simplicity reasons, the above sequence of events enables the organisation to obtain a complete view of how an individual item was transported.

The Aggregation Events (V1, V2, V3, V5 and V6) allow for precise knowledge which individual products were, at which point in time, packed into which containers and hauled with which means of transport (here: a truck and a vessel).

If someone is interested to know whether temperature and air humidity (in this regard, `uom` "A93" stands for gram per cubic metre, a possible unit for measuring absolute humidity) were below an acceptable level, the accessing application only needs to query for the corresponding daily sensor reporting events via the data owner's EPCIS repository (V8 and V10).

Event V9 illustrates how the sensor-related standard extension fields can be used to transmit geographic positions of a given item. In this instance, the EPCIS capturing application triggers an event at the end of each day, thereby inserting the latitude/longitude values in 4-hour intervals. Further, if an accessing client is interested in more granular data, the event also includes a Web URI (which again is a valid GS1 Digital Link Web URI - thereby, '8004' is the GS1 AI for a Global Individual Asset Identifier) pointing to the underlying raw sensor data.

## Example 4: ??? Long-term/fixed associations

TBD  
o need: visibility which sensor device/assembly/module was built into  which product/asset/building  
o for instance, if it turns out in retrospect that a given sensor device/model was not exactly calibrated, the organisation most probably requires to identify all objects equipped with the sensor device in question. In addition, this information may also be enquired by customs authorities  
o visibility data matrix: Association Event  
o example: asset pool operator  

## Example 5: ??? Microorganism/Chemical Substance

TBD  
o need: quality control of e.g. fresh fruits and vegetables, control/random sample at goods receipt  
o visibility data matrix: inspecting event with a device that determines sugar content, consistency, check for bacteria (e.g. Lactobacillus)  
o example: retailer receiving a batch/lot of apples  
