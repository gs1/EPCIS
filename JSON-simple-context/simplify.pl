#!perl -p -i

s{https://gs1.github.io/EPCIS/epcis-context.jsonld}{https://gs1.github.io/EPCIS/epcis-context-simple.jsonld};
s{https://vladimiralexiev.github.io/EPCIS/epcis-context-simple.jsonld}{https://gs1.github.io/EPCIS/epcis-context-simple.jsonld};
s{urn:epcglobal:cbv:bizstep:}{};
s{urn:epcglobal:cbv:disp:}{};
s{urn:epcglobal:cbv:btt:}{};
s{urn:epcglobal:cbv:sdt:}{};
s{urn:epcglobal:cbv:er:}{};
s{gs1:}{};
