TTL = $(wildcard ../Turtle/*.ttl) $(wildcard ../Turtle/*/*.ttl)
PNG = $(TTL:../Turtle/%.ttl=%.png)
RDFPUML = $(HOME)/Downloads/rdf2rml-master/bin/rdfpuml.pl
PLANTUML = $(HOME)/Downloads/rdf2rml-master/bin/plantuml.1.2021.7.jar

all: $(PNG)

# https://stackoverflow.com/questions/66764608/why-make-implicit-rule-doesnt-work-across-folders
define ttl2png
$(1).png: ../Turtle/$(1).ttl
	cp $$^ temp.ttl
	perl -S $(RDFPUML) temp.ttl
	java -jar $(PLANTUML) temp.puml
	mv -f temp.png $$@
	rm temp.ttl temp.puml
endef

$(foreach X,$(PNG:%.png=%),$(eval $(call ttl2png,$(X))))