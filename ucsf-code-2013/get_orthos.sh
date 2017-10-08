#!/bin/bash

#GENE_SYMBOLS="$(cat list_of_gene_symbols.txt)"
GENE_SYMBOLS="Gr32a
				Gr33a
				Gr68a
			"

ORTHO_IDS="gene_orthologs_fb_2013_03.tsv"

echo "getting orthologs for D. mel genes:"
echo ${GENE_SYMBOLS} | tr [[:space:]] '\n'
echo "-----------------------------------"
for GS in ${GENE_SYMBOLS}; do
	echo "${GS}  --> ${GS}-orthos.txt"
	cut -d'	' -f2- ${ORTHO_IDS} | grep -E "^${GS}" |\
					cut -d'	' -f5 > ${GS}-orthos.txt
done
echo ">> use batch retriever @ http://flybase.org/static_pages/downloads/ID.html"
echo 
echo "!! todo: automated batch retriever using urllib2 POST statements"
