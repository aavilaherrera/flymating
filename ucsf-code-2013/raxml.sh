#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 jobname" >> /dev/stderr
	echo "-- where jobname.tre jobname.phy exist" >> /dev/stderr
	exit 1
fi


RX="/home/aram/bin/raxmlHPC-PTHREADS-SSE3"
JB="${1}"

ALN="${JB}.phy"
TPO="${JB}.tre"

TRE="RAxML_result.${JB}"


CHK="$(ls RAxML_*.${JB} 2> /dev/null )"

if [ "${CHK}" != '' ]; then
	echo -e "!! $0: clean directory with [  rm RAxML_*.${JB}  ]\n\n" >> /dev/stderr
fi

${RX} -n ${JB} -s ${ALN} -r ${TPO} -m PROTGAMMAWAGF -p 123456 -T 12 -f e

sed -e 's/:0.0;/;/' ${TRE} > ${JB}.anctre
tail -n+2 ${ALN} > ${ALN%.phy}.ancphy


