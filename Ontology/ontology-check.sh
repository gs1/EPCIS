perl -00ne 'print unless m{rdfs:label|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'                EPCIS.ttl
perl -00ne 'print unless m{rdfs:label|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'                CBV.ttl
perl -00ne 'print unless m{rdfs:isDefinedBy|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'          EPCIS.ttl
perl -00ne 'print unless m{rdfs:isDefinedBy|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'          CBV.ttl
perl -00ne 'print unless m{rdfs:comment|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'              EPCIS.ttl
perl -00ne 'print unless m{rdfs:comment|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'              CBV.ttl
perl -00ne 'print unless m{sw:term_status +"stable"|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'  EPCIS.ttl
perl -00ne 'print unless m{sw:term_status +"stable"|\@prefix|owl:Ontology|schema:Organization|#####|"isA"}'  CBV.ttl
perl -00ne 'print if m{TODO}' EPCIS.ttl
perl -00ne 'print if m{TODO}' CBV.ttl
