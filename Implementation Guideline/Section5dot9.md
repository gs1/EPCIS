# 5.9 Sensor-based quality data 

To improve e.g. patient safety, consumer protection, supply chain visibility and food safety, there is a growing need to capture and share sensor data. The Sensor Element, introduced as of EPCIS 2.0, allows organisations to provide trading partners such data in a standardised manner – for instance, if they want to prove that goods never exceeded a specific sensor property value during the time they had custody of these items.

It is of paramount importance that EPCIS is not meant to transmit raw sensor data dumps. Rather, its added value consists in the ability to provide applications business-oriented, aggregated sensor data. For example, retailers typically are just interested in knowing whether they can put received goods on their shelves or not – in other words, if products were handled within an agreed temperature range. They are not concerned about discrete temperature values at specific timestamps. Therefore, even though the EPCIS data model would *theoretically* allow to accommodate time-stamped sensor data, organisations should model EPCIS events transmitting sensor data very carefully. (Note: even if there is a need to access the original sensor data underlying a given EPCIS event, organisations can use the standard field rawData to point to that data without having to blow up the EPCIS event itself.)

## Example 1: Control/prove temperature compliance

Suppose an organisation that trades temperature-sensitive goods (e.g. cheese, wine, pharmaceutical products) has set up the necessary hardware to capture both the identities as well as the temperature values of items when the latter are in the company's custody.

Now, if this organisation wants to provide that data to internal or external stakeholders (e.g. the company's quality assurance department or trading partners that wish to ascertain if specific items were handled/transported properly), it makes a lot of sense to use a standard format from the outset.

Typical critical tracing events accommodating sensor data can easily be modelled as EPCIS events. Following the usual approach, a visibility data matrix could look like this (the table focusses on the relevant excerpt of the overall chain of events):

| Dim | Data Element | V1 | V2 | V3 | V4 |
| --- | ------------ | -- | -- | -- | -- |
| When | `Event Time` | 15 June, 08:00 am | 15 June, 08:15 am | 15 June, 05:45 pm | 15 June, 11:59 pm |
| What | `EPC List` | SSCC of logistics unit | SSCC of logistics unit | SSCC of logistics unit | (empty) |
| Where | `Read Point` | GLN of receiving area | GLN of interim storage room | GLN of cold storage room | GLN of cold storage room |
| | `Business Location` | GLN of interim storage room | GLN of cold storage room | GLN of shipping area | (empty) |
| Why | `Business Step` | `Storing (CBV)` | `Storing (CBV)` | `Storing (CBV)` | `Sensor reporting (CBV)` |
| How | `Start Time` | 15 June 07:55 am | 15 June 08:10 am | 15 June 05:35 pm | 15 June 00:00 am |
| | `End Time` | 15 June 07:59 am | 15 June 08:14 am | 15 June 05:55 pm | 15 June 11:59 pm |
| | `Type` | `Temperature (CBV`) | `Temperature (CBV)` | `Temperature (CBV)` | `Temperature (CBV)` |
| | `Min Value` | 12 | 12.1 | 9.2 | 9.1 |
| | `Max Value` | 12.1 | 12.2 | 9.2 | 9.4 |
| | `UOM` | `CEL` | `CEL` | `CEL` | `CEL` |

On this basis, the organisation has an unbroken chain of events documenting the condition of an individual item, beginning from when it was relocated from the receiving area to an interim storage room (V1), when it was moved in and out of the cold storage room (V2 and V3), and while it was residing in the cold storage room (V4).

As to V4, note that as of as of EPCIS/CBV 2.0, a CBV-compliant EPCIS event is allowed to have an empty WHAT dimension, if a non-empty Sensor Element is present. In such a case, the object of observation is the physical location indicated in the WHERE dimension (i.e. populating either readPoint or bizLocation). Also, V4 leverages bizStep 'sensor_reporting' which is an appropriate choice when no actual business process step is ongoing.

With regard to designing the HOW dimension, the organisation has ample flexibility. For instance, they *could* have included a pointer to the underlying raw sensor data (rawData), indicated the ID of the respective sensor devices (deviceID) or inserted a reference to the meta data of a given sensor device (deviceMetaData). For simplicity, we assume that the business need consists in controlling that the ambient temperature did not exceed a specific minimum or maximum value. For this purpose, the company can get by with a very concise set of attributes: the start and end time of a related sensor reading as well as the highest and lowermost temperature value within that period, expressed in degree Celsius.

In this context, the company could also have chosen another appropriate unit of measure listed in UN/ECE Recommendation 20 (i.e. Kelvin, degrees Fahrenheit or Rankine).

For convenience and to ease implementation, GS1 provides an Open Source library to automatically convert between any quantitative value of a given property type (e.g. temperature). The library is available at
https://github.com/gs1/UnitConverterUNECERec20.  

## Example 2: Exception notification 

e.g. temperature excursion 

easy example: temperature of cold storage room exceeds predefined threshold   


## Example 3: Sea container 

Aggregation Event SGTIN => SSCC => BIC 

Pallets are loaded/unloaded 

Association Event sensor device => Container 