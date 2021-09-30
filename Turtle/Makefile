JSONLD = $(wildcard ../JSON/*.jsonld) $(wildcard ../JSON/*/*.jsonld)
TTL    = $(JSONLD:../JSON/%.jsonld=%.ttl)

all: $(TTL)

clean: 
	rm $(TTL)

# https://stackoverflow.com/questions/66764608/why-make-implicit-rule-doesnt-work-across-folders
define jsonld2ttl
$(1).ttl: ../JSON/$(1).jsonld
	jsonld format -q $$^ | cat prefixes.ttl - | riot -syntax ttl -formatted ttl > $$@
endef

$(foreach X,$(patsubst ../JSON/%.jsonld,%,$(JSONLD)),$(eval $(call jsonld2ttl,$(X))))
