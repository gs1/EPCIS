# Schema Injector

This script allows injecting the EPCIS 2.0 JSON Schemas and examples (including XML examples) into the REST API Specification.
As a result there are no inconsistencies between the JSON Schemas and the REST API Spec. 

The script takes as input the `openapi.yaml` file and injects the corresponding subordinate files producing a final `openapi.json` file.

The `openapi.json` file is generated automatically and it shall never be edited manually. All changes must be made through the
`openapi.yaml` file. The `openapi.json` file is auto-contained and can be published to any Open API 3.0.3 visualization tool.

To generate the final, single file, inlined spec you need to ensure you have installed 
the [Node.js](https://nodejs.org/en/download/) runtime and the [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) package manager. Then on the command line just execute

```
npm install
chmod +x inject-schema.sh
inject-schema.sh
```

After successfully running the script above, the single, inlined specification `openapi.json` 
will be generated on the `REST Bindings` folder. It is included to allow 
Open API tools to just deal with one file. It contains all the Schemas and Open API constructs defined by the EPCIS 2.0 specification.
