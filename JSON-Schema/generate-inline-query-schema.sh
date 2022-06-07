#!/bin/bash

node inline-schema.js EPCIS-Query-JSON-Schema-root.json "https://gs1.github.io/EPCIS/REST%20Bindings/query-schema.json" > "../REST Bindings/query-schema.json"
