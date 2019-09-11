# GS1 EPCIS 2.0 REST Bindings

This folder contains the work in progress for the EPCIS 2.0 REST interface.
The [EPCIS 2.0 REST bindings](openapi.yaml) are described using
[OpenApi Specifications 3.01](https://github.com/OAI/OpenAPI-Specification/).


## Reading, editing and validating OpenAPI specification for EPCIS 2.0


If you have an IntelliJ-based IDE, install the [Swagger Plugin](https://github.com/zalando/intellij-swagger)
through the plugin manager.

To ensure the validity of the [EPCIS REST bindings](openapi.yaml), use a validator such as openapi-spec-validator.
Assuming you have Python installed, install openapi-spec-validator:`pip install openapi-spec-validator`.
openapi-spec-validator can be executed from the terminal or loaded as a module. To run it from the terminal, type
`openapi-spec-validator openapi.yaml`.
