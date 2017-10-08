#!/bin/bash
# --- checks if everything is ready to run codeml

## 1 ##
# Download latest ortholog mappings from flybase
# eg. 
# wget 'http://flybase.org/static_pages/downloads/FB2013_03/genes/gene_orthologs_fb_2013_03.tsv.gz'
# tar -zxf gene_orthologs_fb_2013_03.tsv.gz
echo "        == 1 =="
echo "Ortholog mapping downloaded and untarred?"

## 2 ##
# edit ORTHO_IDS and GENE_SYMBOLS in get_orthos.sh
# eg. ORTHO_IDS="gene_orthologs_fb_2013_03.tsv"
# eg. GENE_SYMBOLS="Gr32a Gr33a Gr68a"
echo "        == 2 =="
./get_orthos.sh

## 3 ##
# for small number of gene families, manually use flybase batch downloader
# -- TODO: automate batch downloading for many gene families
# naming convention: GS-orthos.fasta -- where GS is D. mel gene symbol
echo "        == 3 =="
echo "Assuming coding sequences retrieved ok..."

## 4 ##
# codon align
echo "        == 4 =="
FILES="$(ls *-orthos.fasta)"
if [ "${FILES}" == "" ]; then
	echo "... no coding sequences found ..."
	exit 4
fi
echo
echo "Gene families found:"
echo "${FILES}"
echo

./trans_pipe.sh *-orthos.fasta
./align_pep.sh *-orthos-pep.fasta # set location of msaprobs in MSAPROBS 
./do_codon_align.sh *-orthos.fasta # ...slight bug with stop codons getting excluded
./format_for_paml.sh *-orthos-cdn-msa.fasta # keep only alphanum + '-_'

echo
echo "Check that *-orthos-cdn-msa.phy headers are unique"
echo "head *-orthos-fa_to_phy.names"
echo


## 5 ##
# Manually build topology from http://flybase.org/static_pages/species/sequenced_species.html
# Species topology file in TOPO_S of make_paml-formatted_gene_topology.sh
# eg. TOPO_S=drosophila_12seqd-human-readable-names.topology
# Manually build "species_name gene_name" table ~ in GS-orthos-topo_to_phy.names
echo "        == 5 =="
FILES="$(ls *-orthos-topo_to_phy.names)"
if [ "${FILES}" == "" ]; then
	echo "... no species to gene tables found ..."
	exit 5
fi
echo "species to gene tables found:"
echo "${FILES}"
echo

./make_paml-formatted_gene_topology.sh *-orthos-topo_to_phy.names

echo "PAML-friendly tree files done."
echo "--> MANUALLY PLACE OMEGA RATES { eg. (((oriCun #1, ratNor #1) #1, homSap), bosTau, phaCin); } ON BRANCHES <--"
echo "$(ls *-orthos.topology)"


