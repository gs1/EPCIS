/* Bundles the EPCIS JSON Schemas into a single file */

const process = require('process');
const fs = require('fs');
const path = require('path');

function loadJson (fileName) {
  return JSON.parse(fs.readFileSync(fileName, 'utf8'));
}

function inline (fileName, schemaId) {
  const inputJson = loadJson(fileName);
  inputJson.$id = schemaId;

  // We visit and inline the input Json
  // We don't assign current definitions to the input because
  // All definitions will be copied to the final schema
  visit(null, null, null, inputJson, inputJson.definitions);

  // Once we have the definitions we add them to the root schema
  inputJson.definitions = definitions;

  return inputJson;
}

// The definitions that will be filled along our visit to the nodes
const definitions = {};

function visit (parent, key, index, node, currentDefinitions) {
  if (typeof node === 'object' && !Array.isArray(node)) {
    let currDefinitions = currentDefinitions;
    if (key === 'definitions') {
      // The definitions are copied (only in the case of the input root schema)
      Object.keys(node).forEach((aKey) => (definitions[aKey] = node[aKey]));
      currDefinitions = node;
    }
    Object.keys(node).forEach((aKey) => {
      visit(node, aKey, null, node[aKey], currDefinitions);
    });
  } else if (typeof node === 'string' && key === '$ref') {
    // Here we inline the definition from the file indicated
    if (!node.startsWith('#')) {
      loadChildSchema(node);
      parent.$ref = localizeDefinition(node);
    } else {
        // This is a local definition that is is copied from currentDefinitions
        const definitionName = node.split('/')[2];
        definitions[definitionName] = currentDefinitions[definitionName];
    }
  } else if (Array.isArray(node)) {
    node.forEach((aElement, aIndex) => {
      visit(node, key, aIndex, aElement, currentDefinitions);
    });
  }
}

function localizeDefinition (definitionPointer) {
  const components = definitionPointer.split('#');
  return `#${components[1]}`;
}

function extractDefinitionName(definitionPointer) {
  const localizedDefinition = localizeDefinition(definitionPointer);
  return localizedDefinition.split('/')[2];
}

function loadChildSchema (definitionPointer) {
  let fileName;

  fileName = definitionPointer.split('#')[0];
  const definitionName = extractDefinitionName(definitionPointer);

  // Check wether the file exists, if it doesn't is a file from the child schemas
  if (!fs.existsSync(fileName)) {
    fileName = path.join('schemas', fileName);
  }

  const childSchema = loadJson(fileName);
  // Definition is copied to the global object with all the definitions
  definitions[definitionName] = childSchema.definitions[definitionName];
  // And we only visit from definitions on
  visit(null, null, null, childSchema.definitions, childSchema.definitions);
}

function main () {
  const inputFile = process.argv[2];
  const schemaId = process.argv[3];

  const inlinedJsonSchema = inline(inputFile, schemaId);

  console.log(JSON.stringify(inlinedJsonSchema, null, 2));
}

main();
