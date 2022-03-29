/* Injects on the Open API Spec the schema definitions from the EPCIS JSON Schema */

const process = require("process");
const fs = require("fs");
const path = require("path");
const yaml = require("js-yaml");

/*  Translation table so that certain JSON Schema definitions are translated
 *  to the Open API compatible definitions
 */
const definitionTranslations = {
  'EPCIS-Document-Event': 'EPCISEvent',
  '@context': 'LDContext'
};

/* Elements that will not be included for OpenAPI Compatibility */
const blackList = ['EPCIS-Document-Event', 'propertyNames', '@context'];

const EPCIS_JSON_SCHEMA = path.basename(process.argv[3]);

function loadJson(fileName) {
  return JSON.parse(fs.readFileSync(fileName, "utf8"));
}

function loadYaml(fileName) {
  return yaml.load(fs.readFileSync(fileName, { encoding: "utf-8" }));
}

function inject(fileName, schemaFileName) {
  const spec = loadYaml(fileName);
  const schemaJson = loadJson(schemaFileName);

  const definitions = schemaJson.definitions;
  const schemas = spec.components.schemas;

  const definitionList = Object.keys(definitions);
  for (const definition of definitionList) {
    if (!blackList.includes(definition)) {
      schemas[definition] = definitions[definition];
    }
  }

  const members = Object.keys(spec);
  for (const member of members) {
    visit(spec[member], member, spec);
  }

  return spec;
}

function visit(obj, parentKeyName, parent) {
  if (!obj || typeof obj !== "object") {
    return;
  }

  if (Array.isArray(obj)) {
    for (const item of obj) {
      visit(item, null, obj);
    }
    return;
  }

  const keys = Object.keys(obj);
  for (const key of keys) {
    if (key === "$ref") {
      const pointer = obj[key];
      if (pointer.startsWith("#/definitions")) {
        obj[key] = `#/components/schemas/${getDefinitionName(obj[key])}`;
      } else if (!pointer.startsWith("#")) {
        // Here there is a Reference to an example or to an schema
        if (parentKeyName === "example") {
          // The example is just inlined
          const example = loadExample(pointer);
          parent[parentKeyName] = example;
        } else if (pointer.includes(EPCIS_JSON_SCHEMA)) {
          // We just reference the schema
          obj[key] = `#/components/schemas/${getDefinitionName(obj[key])}`;
        }
      }
    } 
    else if (blackList.includes(key)) {
      delete obj[key];
    }
    else {
      visit(obj[key], key, obj);
    }
  }
}

function getDefinitionName(reference) {
  const components = reference.split("/");
  let result = components[components.length - 1];
  if (definitionTranslations[result]) {
    result = definitionTranslations[result];
  }

  return result;
}

function loadExample(definitionPointer) {
  let fileName;

  fileName = definitionPointer.split("#")[0];

  // We obtain the file relative to the folder where the openapi.yaml is
  const folder = path.dirname(process.argv[2]);
  const finalFileLocation = path.join(folder, fileName);

  const example = loadJson(finalFileLocation);

  return example;
}

function main() {
  const inputFile = process.argv[2];
  const schemaFile = process.argv[3];

  const finalSpec = inject(inputFile, schemaFile);

  console.log(JSON.stringify(finalSpec, null, 2));
}

main();
