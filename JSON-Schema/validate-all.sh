#!/bin/bash

# needs to copy to a file with JSON extension due to `ajv` limitation
validate () {
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            validate "$pathname"
        else
            case "$pathname" in
                *.jsonld)
                cp "$pathname" "$pathname".json
                ajv validate -c ajv-formats -s ../EPCIS-JSON-Schema.json -d "$pathname".json
                rm "$pathname".json
            esac
        fi
    done
}

validate "../JSON"
