#!sh
find -name '*.jsonld' -exec perl -p -i simplify.pl {} \;
