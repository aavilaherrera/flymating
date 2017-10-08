#!/bin/bash
# runs phastCons on dmel-masked alignments
# used to recall phastCons elements
# 

if [ $# -ne 2 ]; then
	echo "usage: $0 grXXy chrZ" >> /dev/stderr
	exit 1
fi

GSDIR="${1%/}"
GS="${GSDIR}"
GSMAF="${GSDIR}/${GS}_regulatory-15way.maf"

###
# MODELS
CONSMOD="drosophila-ucsc-15way-ave.cons.mod"
NONCONSMOD="drosophila-ucsc-15way-ave.noncons.mod"

echo "checking files for ${GS}" >> /dev/stderr
for F in ${GSDIR} ${GSMAF} ${NONCONSMOD} ${CONSMOD}; do
	if [ -e ${F} ]; then
		echo "---> ${F} exists!" >> /dev/stderr
	else
		echo "!!-> ${F} does not exist" >> /dev/stderr
	fi
done

echo >> /dev/stderr
echo >> /dev/stderr

# convert MAF to SS
GSSS=${GSMAF%.maf}.ss
GSSSm=${GSSS%.ss}-dmel_masked.ss
msa_view --in-format MAF --out-format SS ${GSMAF} > ${GSSS}

# mask
gawk '{if($1~/[0-9]/ && $2~/^[ACGT]/){print $1"\tN"substr($2,2,length($2))"\t"$3;}else{print $0}}' ${GSSS} > ${GSSSm}

# phastCons
GSBED="${GSDIR}/${GS}_regulatory-15way-cons_el-dmel_masked.bed"
#phastCons ${GSSSm} ${CONSMOD},${NONCONSMOD} --target-coverage 0.9 --expected-length 120 \
phastCons ${GSSSm} ${NONCONSMOD} --rho 0.6 --target-coverage 0.6 --expected-length 120 \
											--seqname ${2} --no-post-probs --score --most-conserved ${GSBED}

