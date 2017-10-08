#!/bin/bash
#
#

CODEML="/home/aram/bin/codeml_4.7"


if [ $# -lt 1 ]; then
	echo "usage: $0 gn1_m7.ctl gn2_m7.ctl..." >> /dev/stderr
	exit 1
fi

for M7 in ${@}; do
	# run CODEML for M7 and M8... rename rst file
	# parse likelihoods
	# chi-sqr w/ 2 deg

	M8=${M7%_m7.ctl}_m8.ctl

	M7out=${M7%.ctl}.paml_out
	M8out=${M8%.ctl}.paml_out
	
	M7rst=${M7%.ctl}.paml_rst
	M8rst=${M8%.ctl}.paml_rst

	${CODEML} ${M7}
	mv rst ${M7rst}
	${CODEML} ${M8}
	mv rst ${M8rst}
	
	M7lnL="$(grep lnL ${M7rst} | awk '{print $3}')"
	M8lnL="$(grep lnL ${M8rst} | awk '{print $3}')"

	./lrt.R ${M7lnL} ${M8lnL} > ${M7%.ctl}_m8.pval

done


