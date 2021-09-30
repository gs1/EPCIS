# EPCIS 2.0 JSON-LD Context

This folder contains the source code for the EPCIS 2.0 JSON-LD @context. 

The `epcis-context-root.jsonld` is the root file that has pointers to the different auxiliary children contexts that define terms corresponding to the GS1 CBV Vocabulary. 

To generate the final, single file, inlined JSON-LD @context you need to ensure you have installed the [Node.js](https://nodejs.org/en/download/) runtime. Then on the command line just execute

```
chmod +x generate-inline-context.sh
generate-inline-context.sh
```

After successfully running the script above, the single, inlined context file `epcis-context.jsonld` will be generated on the root folder of the EPCIS repository. 
