#!/bin/bash
# run codon_align.py for seqs on commandline

if [ $# -lt 1 ]; then
	echo "usage: $0 nuc1.fasta nuc2.fasta..." >> /dev/stderr
	exit 1
fi

for FA in ${@}; do
	PEPMSA="${FA%.*}-pep-msa.fasta"
	if [ ! -f ${PEPMSA} ]; then
		echo "guide peptide msa =[ ${PEPMSA} ]= does not exist"
		exit 2
	fi
	python codon_align.py ${PEPMSA} ${FA} > ${PEPMSA/-pep-/-cdn-}
done
