#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 grXXy" >> /dev/stderr
	exit 1
fi

GSDIR="${1%/}"
GS="${GSDIR}"
GSMAF="${GSDIR}/${GS}_regulatory-15way.maf"
GSBED="${GSDIR}/${GS}_regulatory-all_cons_el.bed"

###
#NEUTRAL MODEL
NMOD="drosophila-ucsc-15way-ave.noncons.mod"
###

echo "checking files for ${GS}" >> /dev/stderr
for F in ${GSDIR} ${GSMAF} ${GSBED} ${NMOD}; do
	if [ -e ${F} ]; then
		echo "---> ${F} exists!" >> /dev/stderr
	else
		echo "!!-> ${F} does not exist" >> /dev/stderr
	fi
done

echo >> /dev/stderr
echo >> /dev/stderr


POUTBYF="${GSDIR}/${GS}_regulatory-by_feature-lrt-acc-dm3.phylop_out"
# phylop dmel acceleration lrt p-values by feature
phyloP -m LRT -o ACC -s dm3 -f ${GSBED} -i MAF ${NMOD} ${GSMAF} \
		> ${POUTBYF}

CATBED="${GSBED%.bed}-merged.bed"
CATMAF="${GSMAF%.maf}-cons_el_only.maf"

mafsInRegion ${GSBED} ${CATMAF} ${GSMAF}
paste <(head -n1 ${GSBED} | cut -d'	' -f-2) \
	<(grep -vE "^[[:space:]]*$" ${GSBED} | tail -n1 | cut -d'	' -f3) > ${CATBED}

POUTMGD="${GSDIR}/${GS}_regulatory-merged_features-lrt-acc-dm3.phylop_out"
phyloP -m LRT -o ACC -s dm3 -f ${CATBED} -i MAF ${NMOD} ${CATMAF} \
		> ${POUTMGD}


echo >> /dev/stderr
echo "output in :" >> /dev/stderr
echo "    ${POUTBYF}" >> /dev/stderr
echo "    ${POUTMGD}" >> /dev/stderr


