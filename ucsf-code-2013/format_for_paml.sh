#!/bin/bash
# simply format all codon alignments for paml

if [ $# -lt 1 ]; then
	echo "usage: $0 aln-cdn.fasta aln-cdn.fasta..." >> /dev/stderr
	exit 1
fi

for FA in ${@}; do
	python fasta_to_paml.py < ${FA} > ${FA%.*}.phy 2> ${FA/-orthos*/-orthos-fa_to_phy}.names
done
