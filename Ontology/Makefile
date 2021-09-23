TTL    = EPCIS.ttl CBV.ttl
JSONLD = EPCIS.jsonld CBV.jsonld 

all: $(JSONLD)

%.jsonld: %.ttl
	riot -formatted jsonld $^ > $@

# all: $(TTL) # Now Turtle is the master ontology format
#%.ttl: %.jsonld prefixes.ttl
#	jsonld format -q $^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $@
