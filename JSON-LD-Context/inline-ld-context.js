const process = require('process');
const fs = require('fs');
const path = require('path');

function loadJson (fileName) {
  return JSON.parse(fs.readFileSync(fileName, 'utf8'));
}

function inline (fileName) {
  const inputJson = loadJson(fileName);

  // We visit and inline the input Json
  visit(null, null, null, inputJson);

  return inputJson;
}

function visit (parent, key, index, node) {
  if (typeof node === 'object' && !Array.isArray(node)) {
    Object.keys(node).forEach(aKey => {
      visit(node, aKey, null, node[aKey]);
    });
  } else if (typeof node === 'string' && key === '@context') {
    // Here we inline the @context from the file indicated
    if (typeof parent === 'object' && !Array.isArray(parent)) {
      parent['@context'] = loadChildContext(node);
    }
    if (Array.isArray(parent)) {
      parent[index] = loadChildContext(node);
    }
  } else if (Array.isArray(node)) {
    node.forEach((aElement, aIndex) => {
      visit(node, key, aIndex, aElement);
    });
  }
}

function loadChildContext (url) {
  const contextURL = new URL(url);
  const fileName = path.basename(contextURL.pathname);
  const childContext = loadJson(fileName);
  return childContext['@context'];
}

function main () {
  const inputFile = process.argv[2];

  const inlinedJson = inline(inputFile);

  console.log(JSON.stringify(inlinedJson, null, 2));
}

main();
