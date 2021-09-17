TTL = $(wildcard ../Turtle-simple-context/*.ttl) $(wildcard ../Turtle-simple-context/*/*.ttl)
PNG = $(TTL:../Turtle-simple-context/%.ttl=%.png)
RDFPUML = $(HOME)/Downloads/rdf2rml-master/bin/rdfpuml.pl
PLANTUML = $(HOME)/Downloads/rdf2rml-master/bin/plantuml.1.2021.7.jar

all: $(PNG)

clean:
	rm $(PNG)

# https://stackoverflow.com/questions/66764608/why-make-implicit-rule-doesnt-work-across-folders
define ttl2png
$(1).png: ../Turtle-simple-context/$(1).ttl
	cp $$^ temp.ttl
	perl -S $(RDFPUML) temp.ttl
	java -jar $(PLANTUML) temp.puml
	mv -f temp.png $$@
	rm temp.ttl temp.puml
endef

$(foreach X,$(PNG:%.png=%),$(eval $(call ttl2png,$(X))))