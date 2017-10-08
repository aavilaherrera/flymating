#!/bin/bash

BED="near_gr32a_reg1.bed"
MAF="near_gr32a_reg1.maf"
MOD="../../drosophila-ucsc-15way-ave.noncons.mod"

for F in ${BED} ${MAF} ${MOD}; do
	if [ ! -f ${F} ]; then
		echo "!! $0 error: file ${F} does not exist" >> /dev/stderr
		exit 1
	fi
done

phyloP -m LRT -o ACC -s dm3 -f ${BED} \
		-i MAF ${MOD} ${MAF} \
		> ${BED%.bed}-by_feature-lrt-acc-dm3.phylop_out


