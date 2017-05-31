#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 grXXy" >> /dev/stderr
	exit 1
fi

GSDIR="${1%/}"
GS="${GSDIR}"
GSMAF="${GSDIR}/${GS}_regulatory-15way.maf"  # sequence alignment
GSBED="${GSDIR}/${GS}_regulatory-all_cons_el.bed"  # phastcons elements in "upstream region"
WINBED="${GSBED%.bed}-windows.bed" # 9 bp windows of CATBED
CATBED="${GSBED%.bed}-merged.bed"  # the span of the phastcons elements (start of first to end of last, including gaps)

MKWIN="/projects/fly_mating/regulatory_regions/mk_window_bed.py"

CHROM="$(head -n1 ${CATBED} | awk '{print $1}')"


###
#NEUTRAL MODEL
NMOD="drosophila-ucsc-15way-ave.noncons.mod"
###

echo "checking files for ${GS}" >> /dev/stderr
for F in ${GSDIR} ${GSMAF} ${CATBED} ${NMOD}; do
	if [ -e ${F} ]; then
		echo "---> ${F} exists!" >> /dev/stderr
	else
		echo "!!-> ${F} does not exist" >> /dev/stderr
	fi
done

echo >> /dev/stderr
echo >> /dev/stderr


python ${MKWIN} ${CATBED} 9 > ${WINBED}

POUTMGD_WIGGLE="${GSDIR}/${GS}_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out"
phyloP -N ${CHROM} -w -m LRT -o CONACC -s dm3 -i MAF ${NMOD} ${GSMAF} \
		> ${POUTMGD_WIGGLE}

POUTMGD_ALL_WIGGLE="${GSDIR}/${GS}_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out"
phyloP -N ${CHROM} -w -m LRT -o CONACC -i MAF ${NMOD} ${GSMAF} \
		> ${POUTMGD_ALL_WIGGLE}

POUTMGD_WINDOWS="${GSDIR}/${GS}_regulatory-region_windows-lrt-conacc-dm3.phylop_out"
phyloP -m LRT -o CONACC -s dm3 -f ${WINBED} -i MAF ${NMOD} ${GSMAF} \
		> ${POUTMGD_WINDOWS}

POUTMGD_ALL_WINDOWS="${GSDIR}/${GS}_regulatory-region_windows-lrt-conacc-allBranches.phylop_out"
phyloP -m LRT -o CONACC -f ${WINBED} -i MAF ${NMOD} ${GSMAF} \
		> ${POUTMGD_ALL_WINDOWS}


