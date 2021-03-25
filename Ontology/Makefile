JSONLD = $(wildcard *.jsonld)
TTL    = $(JSONLD:%.jsonld=%.ttl)

all: $(TTL)

%.ttl: %.jsonld prefixes.ttl
	jsonld format -q $^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $@
