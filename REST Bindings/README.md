# GS1 EPCIS 2.0 REST Bindings

This folder contains the work in progress for the EPCIS 2.0 REST interface. The [EPCIS 2.0 REST bindings](openapi.yaml) are described using OpenAPI 3.0 Specifications. A human friendly visualization of this file is provided via the [online Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/gs1/EPCIS/master/REST%20Bindings/openapi.json).

Additionally two JSON schema files are available to describe the [EPCIS Query Language](query-schema.json) and the [EPCIS Query Schedule syntax](query-schedule.json).

The [openapi.yaml](openapi.yaml) file is the one that can be edited. Conversely, the [openapi.json](openapi.json) file is generated automatically (from `openapi.yaml`and the EPCIS JSON Schema) through the [Schema Injector tool](./schema-injector).

## Validating the OpenAPI specification for EPCIS 2.0

To ensure the validity of the [EPCIS REST bindings](openapi.yaml), use a validator such as openapi-spec-validator.
Assuming you have Python installed, install openapi-spec-validator:`pip install openapi-spec-validator`.
openapi-spec-validator can be executed from the terminal or loaded as a module. To run it from the terminal, type
`openapi-spec-validator openapi.yaml`.
