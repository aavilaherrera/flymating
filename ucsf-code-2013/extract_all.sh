#!/bin/bash

JOB="gr32a gr33a gr68a"



#PAML
for GS in ${JOB}; do
	./rst_codon_alignments.py < ../${GS}_m8.paml_rst > ${GS}-ancestral_codon-PAML.fasta
	./rst_labeled_tree.py < ../${GS}_m8.paml_rst > ${GS}-ancestral_codon-PAML.tree
done

#ANCESCON
for GS in ${JOB}; do
	./ancout_protein_alignments.py < ../ancescon_reconstruction/${GS}.ancout > ${GS}-ancestral_protein-ANCESCON.fasta
	./ancout_labeled_tree.py < ../ancescon_reconstruction/${GS}.ancout > ${GS}-ancestral_protein-ANCESCON.tree
done

#ANCESCON Dmel Dsim
/home/aram/bin/grepFasta ANC_node_19 gr32a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr32a_dmel-dsim_anc-ANCESCON.fasta
/home/aram/bin/grepFasta ANC_node_19 gr33a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr33a_dmel-dsim_anc-ANCESCON.fasta
/home/aram/bin/grepFasta ANC_node_15 gr68a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr68a_dmel-dsim_anc-ANCESCON.fasta

#ANCESCON Dmel Dyak
/home/aram/bin/grepFasta ANC_node_18 gr32a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr32a_dmel-dyak_anc-ANCESCON.fasta
/home/aram/bin/grepFasta ANC_node_18 gr33a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr33a_dmel-dyak_anc-ANCESCON.fasta
/home/aram/bin/grepFasta ANC_node_14 gr68a-ancestral_protein-ANCESCON.fasta | sed -e '/^>/! s/-//g' > gr68a_dmel-dyak_anc-ANCESCON.fasta


