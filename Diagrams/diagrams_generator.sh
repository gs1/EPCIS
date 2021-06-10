#!/bin/bash
#Setup tools
export RDFPUML=$HOME$'/Downloads/rdf2rml-master/bin/rdfpuml.pl'
export PLANTUML=$HOME$'/Downloads/rdf2rml-master/bin/plantuml.1.2021.7.jar'

#Append puml.ttl
for a in $(find ../Turtle/ -name '*.ttl')
do
  echo "Generate pumls $a"
	cat $a puml.ttl > $a.puml.ttl
done

#Rename 1
for b in $(find ../Turtle/ -name '*.ttl.puml.ttl')
do
  echo "Rename files with exstention .ttl.puml.ttl "
  mv -- "$b" "${b%.ttl.puml.ttl}.puml.ttl"
done

#Move puml ttl to Diagram directory
echo "Move puml ttl to Diagram directory"
find ./../Turtle/ -name '*.puml.ttl' -exec mv -t . {} \;

# Generate pumls
for ttl in $(find . -name '*.puml.ttl')
do
  echo "Generate pumls $ttl"
	perl $RDFPUML $ttl
done

#Rename 2
for c in $(find . -name '*.puml.puml')
do
  echo "Rename files"
  mv -- "$c" "${c%.puml.puml}.puml"
done

# Generate diagrams.
for puml in $(find . -name '*.puml')
do
  echo "Generate diagrams $puml"
	java -jar $PLANTUML $puml
done

#Remove pumls
echo "Remove pumls"
find . -name '*.puml' -exec rm -rf {} \;

#Move into subfolders
echo "Move into AssociationEvent folder"
find . -name 'Association*' -exec mv -t AssociationEvent/ {} \;

echo "Move into SensorDataExample folder"
find . -name 'SensorDataExample*' -exec mv -t WithSensorData/ {} \;

echo "Move into WithErrorDeclaration folder"
find . -name 'ErrorDeclaration*' -exec mv -t WithErrorDeclaration/ {} \;

echo "Move into WithDigitalLinkID folder"
find . -name '*WithDigitalLink*' -exec mv -t WithDigitalLinkID/ {} \;