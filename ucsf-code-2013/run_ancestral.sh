#!/bin/bash

ANC="/home/aram/bin/ancestral"

if [ $# -ne 1 ]; then
	echo "usage: $0 jobname" >> /dev/stderr
	echo "-- where jobname.anctre jobname.ancphy exist" >> /dev/stderr
	exit 1
fi

JB="${1}"

${ANC} -C -R -i ${JB}.ancphy -t ${JB}.anctre -o ${JB}.ancout
