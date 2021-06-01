perl -00ne 'print unless m{rdfs:label|\@prefix}'                EPCIS.ttl
perl -00ne 'print unless m{rdfs:label|\@prefix}'                CBV.ttl
perl -00ne 'print unless m{rdfs:isDefinedBy|\@prefix}'          EPCIS.ttl
perl -00ne 'print unless m{rdfs:isDefinedBy|\@prefix}'          CBV.ttl
perl -00ne 'print unless m{rdfs:comment|\@prefix}'              EPCIS.ttl
perl -00ne 'print unless m{rdfs:comment|\@prefix}'              CBV.ttl
perl -00ne 'print unless m{sw:term_status +"stable"|\@prefix}'  EPCIS.ttl
perl -00ne 'print unless m{sw:term_status +"stable"|\@prefix}'  CBV.ttl
perl -00ne 'print if m{TODO}'                                   EPCIS.ttl
perl -00ne 'print if m{TODO}'                                   CBV.ttl
