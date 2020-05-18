# 5.9 Sensor-based quality data 

To improve e.g. patient safety, consumer protection, supply chain visibility and food safety, there is a growing need to capture and share sensor data. The SensorElement allows organisations to provide trading partners such data in a standardised manner – for instance, if they want to prove that goods never exceeded a specific sensor property value during the time they had custody of these items.

It is of paramount importance that EPCIS is not a means to transmit raw sensor data dumps. Rather, its added value consists in the ability to provide applications business-oriented, aggregated sensor data. For example, retailers typically are just interested to know whether they can put received goods on their shelves or not – in other words, if products were handled within an agreed temperature range. They are not concerned about discrete temperature values at specific timestamps. Therefore, even though the EPCIS data model would theoretically allow to accommodate time-stamped sensor data, organisations should model EPCIS events transmitting sensor data very carefully. (Note: even if there is a need to access the original sensor data underlying a given EPCIS event, organisations can use the standard field rawData to point to that data without having to blow up the EPCIS event itself.)   

<table>
    <thead>
        <tr>
            <th>Dim</th>
            <th>Data Element</th>
            <th>V1</th>
            <th>V2</th>
            <th>V3</th>
            <th>V4</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>When</td>
            <td>Event Time</td>
            <td>15 June, 08:00 am</td>
            <td>15 June, 08:15 am</td>
            <td>15 June, 05:45 pm</td>
            <td>15 June, 11:59 pm</td>
        </tr>
        <tr>
            <td>What</td>
            <td>EPC List</td>
            <td colspan=3>SSCC of logistics unit</td>
            <td>(empty)
        </tr>
        <tr>
            <td>Where</td>
            <td>Read Point</td>
            <td>GLN of receiving area</td>
            <td>GLN of interim storage room</td>
            <td>GLN of cold storage room</td>
            <td>GLN of cold storage room</td>
        </tr>
        <tr>
            <td/>
            <td>Business Location</td>
            <td>GLN of interim storage room</td>
            <td>GLN of cold storage room</td>
            <td>(empty)</td>
            <td>GLN of shipping area</td>
        </tr>
        <tr>
            <td>Why</td>
            <td>Business Step</td>
            <td colspan=3>Storing (CBV)</td>
            <td>Sensor reporting (CBV)</td>
        </tr>
        <tr>
            <td>How</td>
            <td>Start Time</td>
            <td>15 June 07:55 am</td>
            <td>15 June 08:10 am</td>
            <td>15 June 05:35 pm</td>
            <td>15 June 00:00 am</td>
        </tr>
        <tr>
            <td>How</td>
            <td>End Time</td>
            <td>15 June 07:59 am</td>
            <td>15 June 08:14 am</td>
            <td>15 June 05:55 pm</td>
            <td>15 June 11:59 pm</td>
        </tr>
        <tr>
            <td/>
            <td>Type</td>
            <td colspan=4>Temperature (CBV)</td>
        </tr>
        <tr>
            <td/>
            <td>Min Value</td>
            <td>12</td>
            <td>12.1</td>
            <td>9.2</td>
            <td>9.1</td>
        </tr>
        <tr>
            <td/>
            <td>Max Value</td>
            <td>12.1</td>
            <td>12.2</td>
            <td>9.2</td>
            <td>9.4</td>
        </tr>
        <tr>
            <td/>
            <td>UOM</td>
            <td>CEL</td>
            <td>CEL</td>
            <td>CEL</td>
            <td>CEL</td>
        </tr>
    </tbody>
</table>
