# GS1 EPCIS 2.0 REST Bindings

This folder contains the work in progress for the EPCIS 2.0 REST interface.
The [EPCIS 2.0 REST bindings](openapi.yaml) are described using OpenAPI 3.0 Specifications

Additionally two JSON schema files are available to describe the [EPCIS Query Language](query-schema.json) and the [EPCIS Query Schedule syntax](query-schedule.json).

## Validating the OpenAPI specification for EPCIS 2.0

To ensure the validity of the [EPCIS REST bindings](openapi.yaml), use a validator such as openapi-spec-validator.
Assuming you have Python installed, install openapi-spec-validator:`pip install openapi-spec-validator`.
openapi-spec-validator can be executed from the terminal or loaded as a module. To run it from the terminal, type
`openapi-spec-validator openapi.yaml`.
