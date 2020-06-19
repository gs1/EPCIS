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
| | `startTime` | 15 June 07:55 am | 15 June 08:10 am | 15 June 05:35 pm | 15 June 00:00 am |
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

In contrast to the previous example, the event accommodates the (optional) `sensorMetaData` field, which in turn contains a reference (the Web URI is a valid GS1 Digital Link URI leveraging a custom (here: "example.com) domain, `253` denotes the GS1 Application Identifier for the Global Document Type Identifier) to an electronic document including the business rule(s) upon which the EPCIS event was captured. The company may decide to also insert additional attributes such as `deviceID`or `deviceMetaData` into this element, if applicable.

Apart from the actual temperature value (exceeding the predefined threshold), the `sensorElement` contains a second `sensorReport` element accommodating an alarm value, expressed as a URI. The latter consists of a custom value - a future GS1 working group may define standard vocabulary for alarm/error code values for this application domain.

## Example 3: Condition monitoring in intermodal transports

Nowadays, goods are often transported through several modes of transport, e.g. in sea containers, trucks or railway carriages. If a companies wants to control whether their products are properly transported, it would make a lot of sense if logistics/transport providers supplies that data in a standardised manner.

For instance, if an organisation is interested in ascertaining that their products were not exposed to a certain level of air humidity during sea transport, the following EPCIS event sequence would make sense:

| Dim | Data Element | V1 | V2 | V3 | V4 | V5 | V6 |
| --- | ------------ | -- | -- | -- | -- | -- | -- |
| When | `eventTime` | 24 June, 08:00 am | 24 June, 02:15 pm | 24 June, 11:59 pm | 25 June, 11:59 pm |
| What | `epcList` | | | | BIC of sea container | | |
|  | `parentID` | SSCC of logistics unit | BIC of sea container | GIAI of the truck  |  |
|  | `childEPCs` | SGTINs of products | SSCC of logistics unit | BIC of sea container |  |
| Where | `readPoint` | GLN of warehouse | GLN of warehouse | GLN of warehouse |  |
| Why | `bizStep` | `Packing (CBV)` | `Loading (CBV)` | `Loading (CBV)` | `Sensor reporting (CBV)` |
| How | `sensorElement` |
| | `sensorReport` |
| | `startTime` |  |  |  | 15 June 00:00 am |
| | `endTime` |  |  |  | 15 June 11:59 pm |
| | `type` |  |  |  | `Temperature (CBV)` |
| | `minValue` |  |  |  | 9.1 |
| | `maxValue` |  |  |  | 9.4 |
| | `uom` |  |  |  | `CEL` |


rawData 

container closed 

if 

Some events (e.g. shipping/receiving, transporting () )

Aggregation Events to truck, ship, etc. also ... for simplicity reasons, omitted  

Geo coordinates?  


Aggregation Event SGTIN => SSCC => BIC 

Pallets are loaded/unloaded 

Association Event sensor device => Container 

## Example 4: Long-term/fixed associations

An organisation ... visibility which sensor device/assembly/module was built in into which 

For instance, if ... it turns out ...not exactly calibrated, ...
identify 
also, there may be customs authorities ... enquiring 

Let us take the example of an asset pool operator 

## Example 5: ??? Microorganism/Chemical Substance
quality control of e.g. fresh fruits and vegetables 
