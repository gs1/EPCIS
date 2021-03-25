# TDS Identifier to EPCIS Object class mapping

| abbr  | class                        | name                                             | comment                                                 |
|-------|------------------------------|--------------------------------------------------|---------------------------------------------------------|
| GTIN  | gs1:Product                  | Global Trade Item Number                         | class of products, goods or services                    |
| LGTIN | gs1:Product                  | GTIN + Batch/Lot                                 | batch or lot of same-class products                     |
| SGTIN | gs1:Product                  | Serialised Global Trade Item Number              | individual product with serial number                   |
| UPUI  | gs1:Product                  | Unit Pack Identifier                             | individual product with third-party   controlled serial |
| GMN   | gs1:ProductModel             |                                                  |                                                         |
| CPI   | gs1:Component                | Component / Part Identifier                      | part number in technical industries, eg automotive      |
| SGLN  | gs1:Place                    | Global Location Number With or Without Extension | business location                                       |
| PGLN  | gs1:Organization             | Global Location Number of Party                  | company or party                                        |
| GINC  | gs1:Consignment              | Global Identification Number for Consignment     | consignment                                             |
| GSIN  | gs1:Shipment                 | Global Shipment Identification Number            | shipment                                                |
| ITIP  | gs1:IndividualTradeItemPiece | Individual Trade Item Piece                      |                                                         |
| GIAI  | gs1:IndividualAsset          | Global Individual Asset Identifier               | fixed asset                                             |
| SSCC  | gs1:LogisticUnit             | Serial Shipping Container Code                   | logistics asset                                         |
| BIC   |                              | BIC Container Code                               | intermodal container in rail and shipping (ISO 6346)    |
| GRAI  | gs1:ReturnableAsset          | Global Returnable Asset Identifier               | returnable asset                                        |
| GSRN  | gs1:ServiceRecipient         | Global Service Relation Number – Recipient       |                                                         |
| GSRNP | gs1:ServiceProvider          | Global Service Relation Number – Provider        |                                                         |
| SRIN  | gs1:ServiceInstance          |                                                  |                                                         |
| GDTI  | gs1:Document                 | Global Document Type Identifier                  | document instance                                       |
| SGCN  | gs1:Coupon                   | Serialised Global Coupon Number                  |                                                         |
| GID   | epcis:Object                 | General Identifier                               |                                                         |
| DOD   |                              | US Department of Defense Identifier              |                                                         |
| ADI   |                              | Aerospace and Defense Identifier                 |                                                         |
| IMOVN |                              | IMO Vessel Number                                | marine vessel                                           |

Sources:
- [EPC Tag Data Standard, version 1.13](https://www.gs1.org/standards/epcrfid-epcis-id-keys/epc-rfid-tds/1-13). GS1, Nov 2019.
  - As transcribed in Wikipedia [Electronic_Product_Code#All_GS1_Identification_Keys](https://en.wikipedia.org/wiki/Electronic_Product_Code#All_GS1_Identification_Keys). Vladimir Alexiev, Feb 2021
- [GS1 Digital Link: Semantics. GS1, To Be 1.2, Draft 0.5](https://www.gs1.org/sites/default/files/docs/gsmp/gs1_dl_semantics_com_rev_clean.pdf), 23 November 2020
  - Table 3.1
  - Table 'classSemantics'
  - Sec 3.9

