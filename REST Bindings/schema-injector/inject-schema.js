/* Injects on the Open API Spec the schema definitions from the EPCIS JSON Schema */

import process from "process";
import fs from "fs";
import path from "path";
import yaml from "js-yaml";
import fetch from 'node-fetch';

/*  Translation table so that certain JSON Schema definitions are translated
 *  to the Open API compatible definitions
 */
const definitionTranslations = {
  'EPCIS-Document-Event': 'EPCISEvent',
  '@context': 'LDContext'
};

/* Definitions that will not be included for OpenAPI Compatibility */
const definitionsBlackList = ['EPCIS-Document-Event', '@context'];

const schemaBlackList = ['propertyNames'];

const EPCIS_JSON_SCHEMA = path.basename(process.argv[3]);

function loadJson(fileName) {
  return JSON.parse(fs.readFileSync(fileName, "utf8"));
}

function loadYaml(fileName) {
  return yaml.load(fs.readFileSync(fileName, { encoding: "utf-8" }));
}

async function inject(fileName, schemaFileName) {
  const spec = loadYaml(fileName);
  const schemaJson = loadJson(schemaFileName);

  const definitions = schemaJson.definitions;
  const schemas = spec.components.schemas;

  const definitionList = Object.keys(definitions);
  for (const definition of definitionList) {
    if (!definitionsBlackList.includes(definition)) {
      schemas[definition] = definitions[definition];
    }
  }

  const members = Object.keys(spec);
  for (const member of members) {
    await visit(spec[member], member, spec);
  }

  return spec;
}

async function visit(obj, parentKeyName, parent) {
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
          const example = await loadExample(pointer);
          parent[parentKeyName] = example;
        } else if (pointer.includes(EPCIS_JSON_SCHEMA)) {
          // We just reference the schema
          obj[key] = `#/components/schemas/${getDefinitionName(obj[key])}`;
        }
      }
    } 
    else if (schemaBlackList.includes(key)) {
      delete obj[key];
    }
    else {
      await visit(obj[key], key, obj);
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

async function loadExample(uri) {
  let example;
  const response = await fetch(uri);

  if (response.ok) {
    if (response.headers.get("content-type").includes("json")) {
      example = await response.json();
    }
    else if (response.headers.get("content-type").includes("xml")) {
      example = await response.text();
    }
  } 
  else {
    console.error("Cannot load example: ", uri);
  }

  return example;
}

async function main() {
  const inputFile = process.argv[2];
  const schemaFile = process.argv[3];

  const finalSpec = await inject(inputFile, schemaFile);

  console.log(JSON.stringify(finalSpec, null, 2));
}

main().then().catch((err) => console.error(err));
