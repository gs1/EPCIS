/* Injects on the Open API Spec the schema definitions from the EPCIS JSON Schema */

const process = require('process');
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

function loadJson (fileName) {
  return JSON.parse(fs.readFileSync(fileName, 'utf8'));
}

function loadYaml (fileName) {
  return yaml.load(fs.readFileSync(fileName, {encoding: 'utf-8'}));
}

function inject (fileName, schemaFileName) {
  const spec = loadYaml(fileName);
  const schemaJson = loadJson(schemaFileName);

  const definitions = schemaJson.definitions;
  const schemas = spec.components.schemas;

  const definitionList = Object.keys(definitions);
  for(const definition of definitionList) {
    schemas[definition] = definitions[definition];
  }

  const members = Object.keys(spec);
  for (const member of members) {
    visit(spec[member], null);
  }

  // We visit and inline the input Json
  // visit(null, null, null, inputJson);

  // Once we have the definitions we add them to the root schema
  // inputJson.definitions = definitions;

  return spec;
}

function visit(obj, parentKeyName, parent) {
  if (!obj || typeof(obj) !== 'object') {
    return;
  }

  const keys = Object.keys(obj);
  for (const key of keys) {
    if (key === '$ref') {
      const pointer = obj[key];
      if (pointer.startsWith('#/definitions')) {
        obj[key] = `#/components/schemas/${getDefinitionName(obj[key])}`;
      }
      else if (!pointer.startsWith('#')) {
        // Here there is a Reference to an example or to an schema
        if (parentKeyName === "example") {
          // The example is just inlined
          const example = loadExample(pointer);
          parent[parentKeyName] = example;
        }
        else {
          // We just reference the schema
          obj[key] = `#/components/schemas/${getDefinitionName(obj[key])}`;
        }
      }
    }
    else {
      visit(obj[key], key, obj);
    }
  }
  
}

function getDefinitionName(reference) {
  const components = reference.split('/');
  return components[components.length - 1];
}


function loadExample (definitionPointer) {
  let fileName;

  fileName = definitionPointer.split('#')[0];

  // We obtain the file relative to the folder where the openapi.yaml is
  const folder = path.dirname(process.argv[2]);
  const finalFileLocation = path.join(folder, fileName);

  const example = loadJson(finalFileLocation);

  return example;
}

function main () {
  const inputFile = process.argv[2];
  const schemaFile = process.argv[3];

  const finalSpec = inject(inputFile, schemaFile);

  console.log(JSON.stringify(finalSpec, null, 2));
}

main();
