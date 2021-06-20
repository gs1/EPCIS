# EPCIS XSL Transformation Tools

Support for downscaling and upscaling between versions 1.2 and 2.0

## XSL Version 2.0

To allow for more concise templates and mode based processing a XSL 2.0 transformation tool is required.
Testing an Makefile is based on the [Apache Xalan](https://xalan.apache.org) XSL toolchain.

### Install Apache Xalan-C++

Xalan-C++ is a fast and reliable tool for XSL Tranformation.

To download and install visit [https://apache.github.io/xalan-c/install.html](https://apache.github.io/xalan-c/install.html)

## Running and Testing

run Xalan

```bash
Xalan  ./test1.xml ./convert-2.0-to-1.2.xsl
```

run Xalan and beautify using xmllint

```bash
Xalan  ./test1.xml ./convert-2.0-to-1.2.xsl | xmllint --format -
```
