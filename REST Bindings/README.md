# GS1 EPCIS 2.0 Bindings



A repository for the GS1 EPCIS 2.0 Working Group contribution.
The [EPCIS 2.0 REST bindings](openapi.yaml) are described using
[OpenApi Specifications 3.01](https://github.com/OAI/OpenAPI-Specification/). We're also working on a
[OData 4.x](https://www.odata.org) profile to describe the EPCIS query language. Please find the draft [here](EPCIS_query_odata.md)


## Reading, editing and validating OpenAPI specification for EPCIS 2.0


If you have an IntelliJ-based IDE, install the [Swagger Plugin](https://github.com/zalando/intellij-swagger)
through the plugin manager.

To ensure the validity of the [EPCIS REST bindings](openapi.yaml), use a validator such as openapi-spec-validator.
Assuming you have Python installed, install openapi-spec-validator:`pip install openapi-spec-validator`.
openapi-spec-validator can be executed from the terminal or loaded as a module. To run it from the terminal, type
`openapi-spec-validator openapi.yaml`.