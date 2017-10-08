#!/bin/bash
# simply translate sequences from commandline

if [ $# -lt 1 ]; then
	echo "usage: $0 nuc1.fasta nuc2.fasta..." >> /dev/stderr
	exit 1
fi

for FA in ${@}; do
	# (msaprobs can't handle stop symbol '*')
	transeq -auto -filter ${FA} | sed -e '/^>/! s/\*//' > ${FA%.*}-pep.fasta
done



