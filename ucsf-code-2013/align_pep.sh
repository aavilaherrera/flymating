#!/bin/bash
# align peptide sequences using msaprobs

MSAPRBS="/home/aram/bin/msaprobs"

if [ $# -lt 1 ]; then
	echo "usage: $0 pep1.fasta pep2.fasta..." >> /dev/stderr
	exit 1
fi

for FA in ${@}; do
	${MSAPRBS} -num_threads 12 -o ${FA%.*}-msa.fasta ${FA}
done


