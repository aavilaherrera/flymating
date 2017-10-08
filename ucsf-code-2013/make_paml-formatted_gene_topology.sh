#!/bin/bash
# generate tree topologies used in paml analysis

#FILES
TOPO_S="drosophila_12seqd-human-readable-names.topology" # species topology

if [ $# -lt 1 ]; then
	echo "usage: $0 file1-topo_to_phy.names file2-topo_to_phy.names..." >> /dev/stderr
	exit 1
fi

for NAMES in ${@}; do
	TMPTOPFL="$(mktemp --tmpdir=`pwd`)"
	LEAFLIST="$(mktemp --tmpdir=`pwd`)"
	TMPTOPPR="$(mktemp --tmpdir=`pwd`)"
	python leaf_nameswitch.py ${NAMES} < ${TOPO_S} > ${TMPTOPFL}
	awk '{print $2}' ${NAMES} > ${LEAFLIST}
	./ape_prune.R ${TMPTOPFL} ${LEAFLIST} ${TMPTOPPR}

	NUM_LEAVES="$(($(grep -o ',' ${TMPTOPPR} | wc -l) + 1))"
	(echo "  ${NUM_LEAVES} 1"; cat ${TMPTOPPR}) > ${NAMES%-topo*}.topology

	rm ${TMPTOPFL}
	rm ${LEAFLIST}
	rm ${TMPTOPPR}
done

