JSONLD = $(wildcard ../JSON-simple-context/*.jsonld) $(wildcard ../JSON-simple-context/*/*.jsonld)
TTL    = $(JSONLD:../JSON-simple-context/%.jsonld=%.ttl)

all: $(TTL)

clean: 
	rm $(TTL)

# https://stackoverflow.com/questions/66764608/why-make-implicit-rule-doesnt-work-across-folders
define jsonld2ttl
$(1).ttl: ../JSON-simple-context/$(1).jsonld
	jsonld format -q $$^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $$@
endef

$(foreach X,$(patsubst ../JSON-simple-context/%.jsonld,%,$(JSONLD)),$(eval $(call jsonld2ttl,$(X))))
