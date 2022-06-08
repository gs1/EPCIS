# EPCIS JSON Schemas

This folder contains the source code for the EPCIS 2.0 JSON Schema. 

The `EPCIS-JSON-Schema-root.json` is the root file that has pointers to the different auxiliary children schemas. 

To generate the final, single file, inlined JSON Schema you need to ensure you have installed 
the [Node.js](https://nodejs.org/en/download/) runtime. Then on the command line just execute

```sh
chmod +x generate-inline-schema.sh
generate-inline-schema.sh
```

After successfully running the script above, the single, inlined schema file `EPCIS-JSON-Schema.json` 
will be generated on the root folder of the EPCIS git repository. It is included to allow 
online validators to just work with one file. It contains all the Schemas defined by this specification.

For generating the EPCIS Query Schema you can

```sh
chmod +x generate-inline-query-schema.sh
generate-inline-query-schema.sh
```

After successfully running the script above, the single, inlined schema file `query-schema.json`
will be generated on the `REST API` folder of the EPCIS git repository. It is included to allow
online validators to just work with one file.

## Validation

For validating EPCIS documents the [ajv](https://www.npmjs.com/package/ajv) tool has to be installed. In addition
the [ajv-formats](https://www.npmjs.com/package/ajv-formats) plugin is also needed. Both tools can be installed using the
[npm](https://docs.npmjs.com/getting-started) package manager that works on top of a [Node.js](https://nodejs.org/en/download/) runtime. You can install both using the [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) scripts. 

The `validate.sh` script allows to validate JSON and automatically includes all the individual child schemas. 

The `validate-all.sh` script allows to validate all the JSON-LD EPCIS files stored on the `JSON` folder. 
