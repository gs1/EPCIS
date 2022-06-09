/* Bundles the EPCIS JSON Schemas into a single file */

const process = require("process");
const fs = require("fs");
const path = require("path");

function loadJson(fileName) {
  return JSON.parse(fs.readFileSync(fileName, "utf8"));
}

function inline(fileName, schemaId) {
  const inputJson = loadJson(fileName);
  inputJson.$id = schemaId;

  // Initial pending definitions are all from the input file
  Object.keys(inputJson.definitions).forEach(
    (aKey) => (pendingDefinitions[aKey] = true)
  );

  // We visit and inline the input Json
  visit(null, null, null, inputJson, inputJson.definitions);

  // Once we have the definitions we add them to the root schema
  inputJson.definitions = definitions;

  return inputJson;
}

// The definitions that will be filled along our visit to the nodes
const definitions = {};

// Pending definitions to enable only adding definitions really referenced
const pendingDefinitions = {};

function visit(parent, key, index, node, currentDefinitions) {
  if (typeof node === "object" && !Array.isArray(node)) {
    Object.keys(node).forEach((aKey) => {
      if (key === "definitions" && pendingDefinitions[aKey]) {
        definitions[aKey] = currentDefinitions[aKey];
        visit(node, aKey, null, node[aKey], currentDefinitions);
        delete pendingDefinitions[aKey];
      } else if (key !== "definitions") {
          visit(node, aKey, null, node[aKey], currentDefinitions);
      }
    });
  } else if (typeof node === "string" && key === "$ref") {
      // Here we inline the definition from the file indicated
      if (!node.startsWith("#")) {
        const localizedDefinition = localizeDefinition(node);
        // The definition is now pending and will be added from its child Schema
        // This way enable only adding those definitions that are really needed
        pendingDefinitions[getDefinitionName(localizedDefinition)] = true;
        // Child Schemas could be loaded several times but we do not care
        loadChildSchema(node);
        parent.$ref = localizedDefinition;
      } else {
          const definitionName = getDefinitionName(node);
          definitions[definitionName] = currentDefinitions[definitionName];
      }
  } else if (Array.isArray(node)) {
      node.forEach((aElement, aIndex) => {
        visit(node, key, aIndex, aElement, currentDefinitions);
      });
  }
}

function localizeDefinition(definitionPointer) {
  const components = definitionPointer.split("#");
  return `#${components[1]}`;
}

function getDefinitionName(definitionPointer) {
  return decodeURIComponent(definitionPointer.split("/")[2]);
}

function loadChildSchema(definitionPointer) {
  let fileName;

  fileName = definitionPointer.split("#")[0];

  // Check wether the file exists, if it doesn't is a file from the child schemas
  if (!fs.existsSync(fileName)) {
    fileName = path.join("schemas", fileName);
  }

  const childSchema = loadJson(fileName);
  visit(null, null, null, childSchema, childSchema.definitions);
}

function main() {
  const inputFile = process.argv[2];
  const schemaId = process.argv[3];

  const inlinedJsonSchema = inline(inputFile, schemaId);

  console.log(JSON.stringify(inlinedJsonSchema, null, 2));
}

main();
