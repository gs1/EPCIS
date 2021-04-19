# TODO: now Turtle is the master ontology format, so figure out how to generate good JSONLD from it
# JSONLD = $(wildcard *.jsonld)
# TTL    = $(JSONLD:%.jsonld=%.ttl)

# all: $(TTL)

%.ttl: %.jsonld prefixes.ttl
	jsonld format -q $^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $@
