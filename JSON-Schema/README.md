# EPCIS JSON Schemas

This folder contains the source code for the EPCIS 2.0 JSON Schema. 

The `EPCIS-JSON-Schema-root.json` is the root file that has pointers to the different auxiliary children schemas. 

To generate the final, single file, inlined JSON Schema you need to ensure you have installed the [Node.js](https://nodejs.org/en/download/) runtime. Then on the command line just execute

```
chmod +x generate-inline-schema.sh
generate-inline-schema.sh
```

After successfully running the script above, the single, inlined schema file `EPCIS-JSON-Schema.json` will be generated on the root folder of the EPCIS repository. It is included to allow online validators to just work with one file. It contains all the Schemas defined by this specification. 

The `validate.sh` script allows to validate JSON and automatically includes all the individual child schemas. 
