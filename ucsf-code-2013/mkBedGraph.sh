#!/bin/bash

if [ $# -ne 2 ]; then
	echo "usage: $0 BED col1,col2,col3,col4 > bedGraph"  >> /dev/stderr
	echo "     eg. $0 derp.bed 1,2,3,8 > derp.bedGraph" >> /dev/stderr
	exit 1
fi

getColumns(){
	tr -s '[[:blank:]]' '\t' | cut -d'	' -f"$@"
}

BED=${1}
shift

echo "getting columns $@" >> /dev/stderr
grep -E "^#" ${BED} | getColumns $@ >&2
echo >> /dev/stderr

getColumns $@ < ${BED} | awk '{ if($1~/^#/){ print $0} else {LFT=(($2+$3-1)*0.5);  printf("%s\t%d\t%d\t%f\n", $1, LFT, LFT+1, $4)}}' | sort -u -k1,1 -k2,2n

