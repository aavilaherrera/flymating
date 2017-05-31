#!/bin/bash
# squashes a bed file from start of leftmost feature to end of rightmost
# like bedtools merge with -d infinity

usage() { echo "Usage: $0 [-n <feature_name>]" 1>&2; exit 1; }

while getopts ":n:" opt; do
    case "${opt}" in
        n)
            name="${OPTARG}"
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -f "$1" ]; then
    bed="$1"
fi
if [ -z "${name}" ]; then
    echo "Feature name not set, defaulting to filename"
    awkopts="-v name="$(basename "${bed%.*}")
else
    awkopts="-v name=$name"
fi

awk $awkopts 'minb == "" || $2 < minb {minb = $2} maxe == "" || $3 > maxe {maxe = $3} END {print $1 "\t" minb "\t" maxe "\t" name}' < "$bed"
