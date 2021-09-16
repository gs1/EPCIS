#!sh
find . -name '*.jsonld' -exec perl -p -i complicate.pl {} \;
