# EPCIS 2.0 WSDL

The [EPCglobal-epcis-query-2_0.wsdl](EPCglobal-epcis-query-2_0.wsdl) supports current EPCIS 2.0 webservice definitations for SOAP XML messaging.

## Generating XML Binding using maven java code generator

For convenience and basic XML binding tests a maven [pom.xml](pom.xml) has been provided. Apache Maven and Java must be installed for running it.

```bash
mvn clean package
```

## Change Logs

- **2022-03** add maven [pom.xml](pom.xml) with JAXB (Java XML Binding) support
