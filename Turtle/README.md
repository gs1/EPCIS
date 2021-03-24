# EPCIS RDF Turtle Examples

We convert all JSON and JSON-LD examples to RDF Turtle automatically for two purposes:

- Turtle is easier to read than JSON-LD
- To validate the faithfulness of the JSON-LD representation and check the details of the corresponding RDF

## jsonld-cli

We use the `jsonld-cli` command-line tool, which uses the JSONLD Playground code and packages it as a `node.js` module (NPM).
- Source: https://github.com/digitalbazaar/jsonld-cli
- Package: https://www.npmjs.com/package/jsonld-cli
- Latest version: 0.3.0 (dated 2018)

### Installation

On Windows: install prerequisites (Python 2.7 and Microsoft CPP). Do this from `cmd`, not `cygwin bash`:
```
npm install --global --production windows-build-tools
setx VCTargetsPath "%programfiles(x86)%\MSBuild\Microsoft.Cpp\v4.0\V140"
```

Then install like this:
```
npm install -g jsonld-cli
```

You may get some warnings, they seem to be harmless. Eg:
```
npm WARN deprecated request@2.88.2: request has been deprecated, see https://github.com/request/request/issues/3142
npm WARN deprecated har-validator@5.1.5: this library is no longer supported
npm WARN deprecated request-promise-native@1.0.9: request-promise-native has been deprecated because it extends the now deprecated request package, see https://github.com/request/request/issues/3142
C:\Users\...\AppData\Roaming\npm\jsonld -> C:\Users\...\AppData\Roaming\npm\node_modules\jsonld-cli\bin\jsonld
+ jsonld-cli@0.3.0
added 3 packages from 11 contributors, removed 2 packages and updated 41 packages in 18.755s
```

### Help

The builtin help `jsonld -h` is quite poor, so we dug out the options from the source https://github.com/digitalbazaar/jsonld-cli/blob/master/bin/jsonld:
```
COMMON OPTIONS
  -i, --indent <spaces>                   spaces to indent [2]
  -N, --no-newline                        do not output the trailing newline [newline]
  -k, --insecure                          allow insecure SSL connections [false]
  -t, --type <type>                       input data type [auto]
  -b, --base <base>                       base IRI []
format [options] [filename|URL|-]     format and convert JSON-LD
  -f, --format <format>                   output format [json]
  -q, --nquads                            output application/nquads [false]
  -j, --json                              output application/json [true]
compact [options] [filename|URL]      compact JSON-LD
  -c, --context <filename|URL>            context filename or URL
  -S, --no-strict                         disable strict mode
  -A, --no-compact-arrays                 disable compacting arrays to single values
  -g, --graph                             always output top-level graph [false]
expand [options] [filename|URL|-]     expand JSON-LD
      --keep-free-floating-nodes          keep free-floating nodes
flatten [options] [filename|URL|-]    flatten JSON-LD
  -c, --context <filename|URL>            context filename or URL for compaction [none]
frame [options] [filename|URL|-]      frame JSON-LD
  -f, --frame <filename|URL>              frame to use
      --embed <embed>                     default @embed flag [true]
      --explicit <explicit>               default @explicit flag [false]
      --omit-default <omit-default>       default @omitDefault flag [false]
normalize [options] [filename|URL|-]  normalize JSON-LD
  -f, --format <format>                   format to output ('application/nquads' for N-Quads)
  -q, --nquads                            use 'application/nquads' format
```
The builtin help gives the following useful advice:
- The input parameter for all commands can be a filename, a URL beginning with "http://" or "https://", or "-" for stdin (the default).
- Input type can be specified as a standard content type or a simple string for common types. See the "request" extension code for available types. XML and HTML variations will be converted with an RDFa processor if available. If the input type is not specified it will be auto-detected based on file extension, URL content type, or by guessing with various parsers. Guessing may not always produce correct results.
- Output type can be specified for the "format" command and a N-Quads shortcut for the "normalize" command. For other commands you can pipe JSON-LD output to the "format" command.

## jena riot

`jsonld-cli` can output only `nquads`, eg:

```sh
jsonld format -f text/turtle ../JSON/Example_9.6.1-ObjectEvent.jsonld > Example_9.6.1-ObjectEvent.ttl
Error: ERROR: Unknown format: text/turtle
```

So we also use `riot` from Apache Jena:
- Download: https://jena.apache.org/download/

We make a file `prefixes.ttl` that defines the same prefixes as the EPCIS context, and postprocess with `riot` to make nicely formtted Turtle
(we use the fact that the `nquads` format output by `jsonld`, when no named graphs are used, is compatible with the `ttl` format):

```sh
jsonld format -q ../JSON/Example_9.6.1-ObjectEvent.jsonld | \
  cat prefixes.ttl - | riot -syntax ttl -formatted ttl > Example_9.6.1-ObjectEvent.ttl
```

## Context Issues

All JSON/JSON-LD examples declare their own context, usually something like this (first is the EPCIS context, then some custom extensions):

```json
  "@context": ["https://gs1.github.io/EPCIS/epcis-context.jsonld",
               {"example": "http://ns.example.com/epcis/"},
               {"gs1": "https://gs1.org/voc/"}],
```

The EPCIS context is served from a Github page and corresponds to the local version [../epcis-context.jsonld](../epcis-context.jsonld) in this repository
(it may show as a smaller file because it uses NL line endings, whereas the local version uses CR+NL line endings on Windows).
This means that:
- Whenever changes are made to [../epcis-context.jsonld](../epcis-context.jsonld), it will take time until it's deployed at Github pages. 
  Furthermore, Github pages aggressively use caching, so one may still get the old context.
- The version in development [../epcis-context-protected.jsonld](../epcis-context-protected.jsonld) cannot be tested so easily.

For example, error #201 still occurs for one of the examples because 
the change `xsd:decimal -> xsd:float` is still not deployed in the context.

TODO: see if option `-c` can override the context specified in-file.
