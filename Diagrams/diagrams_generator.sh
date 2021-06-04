#!/bin/bash
#Setup tools
export RDFPUML=$HOME$'/Downloads/rdf2rml-master/bin/rdfpuml.pl'
export PLANTUML=$HOME$'/Downloads/rdf2rml-master/bin/plantuml.1.2021.7.jar'

# Generate pumls
for ttl in $(find ../Turtle/ -name '*.ttl')
do
  echo "Generate pumls $ttl"
	perl $RDFPUML $ttl
done

# Generate diagrams.
for puml in $(find ../Turtle/ -name '*.puml')
do
  echo "Generate diagrams $puml"
	java -jar $PLANTUML $puml
done

#Delete Pumls
echo "Delete pumls"
find ./../Turtle/ -name '*.puml' -exec rm -rf {} \;

#Move PNGs to Diagram folder
echo "Move PNGs to Diagram directory"
find ./../Turtle/ -name '*.png' -exec mv -t . {} \;