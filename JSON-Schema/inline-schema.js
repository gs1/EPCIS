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
  visit(null, null, null, inputJson);

  // Once we have the definitions we add them to the root schema
  inputJson.definitions = definitions;

  return inputJson;
}

// The definitions that will be filled along our visit to the nodes
const definitions = {};

function visit (parent, key, index, node) {
  if (typeof node === 'object' && !Array.isArray(node)) {
    if (key === 'definitions') {
      // The definitions are copied
      Object.keys(node).forEach((aKey) => (definitions[aKey] = node[aKey]));
    }
    Object.keys(node).forEach((aKey) => {
      visit(node, aKey, null, node[aKey]);
    });
  } else if (typeof node === 'string' && key === '$ref') {
    // Here we inline the definition from the file indicated
    if (!node.startsWith('#')) {
      loadChildSchema(node);
      parent.$ref = localizeDefinition(node);
    }
  } else if (Array.isArray(node)) {
    node.forEach((aElement, aIndex) => {
      visit(node, key, aIndex, aElement);
    });
  }
}

function localizeDefinition (definitionPointer) {
  const components = definitionPointer.split('#');
  return `#${components[1]}`;
}

function loadChildSchema (definitionPointer) {
  let fileName;

  fileName = definitionPointer.split('#')[0];

  // Check wether the file exists, if it doesn't is a file from the child schemas
  if (!fs.existsSync(fileName)) {
    fileName = path.join('schemas', fileName);
  }

  const childSchema = loadJson(fileName);
  visit(null, null, null, childSchema);
}

function main () {
  const inputFile = process.argv[2];
  const schemaId = process.argv[3];

  const inlinedJsonSchema = inline(inputFile, schemaId);

  console.log(JSON.stringify(inlinedJsonSchema, null, 2));
}

main();
