#!/bin/bash

# Wrapper template to generate a bundle
cat <<EOF > epcis-wrapper.template.json
{
    "openapi": "3.0.2",
    "info": {
        "title": "Temp Wrapper",
        "version": "0.0.0"
    },
    "paths": {},
    "components": {
        "schemas": {
            "schemaWrapper": {
                "oneOf": .oneOf
            }
        }
    }
}
EOF

# Extract the root schema declarations and put on the wrapper
cat EPCIS-JSON-Schema.json | jq "$(cat epcis-wrapper.template.json)" > epcis-wrapper.json

# Generate the bundle 
swagger-cli bundle -r -o EPCIS-JSON-Schema-bundled-wrapped.json epcis-wrapper.json

# Generate the final bundle schema. Template
cat <<EOF > EPCIS-JSON-Schema-bundled.template.json
{
    "\$id": "https://gs1.github.io/EPCIS/JSON/modular-schema/EPCIS-JSON-Schema-bundled.json",
    "\$schema": "http://json-schema.org/draft-07/schema#",
    "oneOf": .components.schemas.schemaWrapper.oneOf
}
EOF

# Bundle unwrapping extraction 
cat EPCIS-JSON-Schema-bundled-wrapped.json | jq "$(cat EPCIS-JSON-Schema-bundled.template.json)" > EPCIS-JSON-Schema-bundled.json

# Clean up files

rm epcis-wrapper.json
rm epcis-wrapper.template.json
rm EPCIS-JSON-Schema-bundled-wrapped.json
rm  EPCIS-JSON-Schema-bundled.template.json
