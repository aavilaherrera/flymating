#!/bin/bash

./prep.sh

for GS in gr32a gr33a gr68a; do
	./raxml.sh ${GS}
	./run_ancestral.sh ${GS}

	echo "!! $0 ${GS} : output in ${GS}.ancout" >> /dev/stderr
done
