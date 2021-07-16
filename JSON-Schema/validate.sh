#!/bin/bash

GLOBIGNORE="$1"
files="$(echo schemas/*-JSON-Schema.json)"
files="${files} $(echo *-JSON-Schema.json)"

referenced_files=""
for file in $files; do
    referenced_files="${referenced_files} -r $file "
done

ajv validate -c ajv-formats $referenced_files -s $1 -d $2
