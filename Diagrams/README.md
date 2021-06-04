Includes RDF diagrams made from the [Turtle](../Turtle) examples using [rdfpuml](https://github.com/VladimirAlexiev/rdf2rml).

TODO:
- Automate with Makefile. See the Turtle makefile for using `make` macros, and ask me for a typical body of commands
- `puml.ttl` are `puml:` instructions that MAY be applicable to all examples.
- Enable per-file `puml:` instructions, eg `Example-Type-sourceOrDestination,measurement,bizTransaction.puml.ttl` to be used together with `Example-Type-sourceOrDestination,measurement,bizTransaction.ttl`

These commands process one file, but they do it in a very wrong way...
```
cp -f ../Turtle/prefixes.ttl .
cat ../Turtle/Example-Type-sourceOrDestination,measurement,bizTransaction.ttl puml.ttl Example-Type-sourceOrDestination,measurement,bizTransaction.puml.ttl > temp.ttl
rdfpuml.bat temp.ttl
puml.bat temp.puml
mv temp.png Example-Type-sourceOrDestination,measurement,bizTransaction.png
rm temp.ttl temp.puml
```

Shell script has been created which generates diagrams for all files in Turtle directory.
To use it, you should have:
- rdfpuml([Link](https://github.com/VladimirAlexiev/rdf2rml))
- plantuml([Link](https://plantuml.com/download)) 

After that you set your env variable of the above tools in `diagrams_generator.sh`.

