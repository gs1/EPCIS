TTL    = EPCIS.ttl CBV.ttl
JSONLD = EPCIS.jsonld CBV.jsonld 

.PHONY: clean all

all: clean $(JSONLD)

%.jsonld: %.ttl
	ttl2jsonld $^ \
	 | jsonld compact -c file://EPCIS-CBV-context.jsonld \
	 | jq -S --slurpfile c EPCIS-CBV-context.jsonld '.["@context"] |= $$c[0]["@context"]' \
	 > $@

# all: $(TTL) # Now Turtle is the master ontology format
#%.ttl: %.jsonld prefixes.ttl
#	jsonld format -q $^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $@

clean:
	rm -f jq.exe.stackdump jq.stackdump
	find -empty -exec rm {} \;
