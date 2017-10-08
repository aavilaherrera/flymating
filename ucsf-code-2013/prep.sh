#!/bin/bash

FA2PHY="/projects/fly_mating/fasta_to_paml.py"
FLYDIR="/projects/fly_mating/flybase_reanalysis"

# TREES
tail -n+2 ${FLYDIR}/fly_tree.tre > gr32a.tre
tail -n+2 ${FLYDIR}/fly_tree.tre > gr33a.tre
tail -n+2 ${FLYDIR}/gr68a_tree.tre > gr68a.tre

# ALIGNMENTS
python ${FA2PHY} < ${FLYDIR}/all_species.guide_tree.translation/FBtr0080198.fasta > gr32a.phy
python ${FA2PHY} < ${FLYDIR}/all_species.guide_tree.translation/FBtr0080337.fasta > gr33a.phy
python ${FA2PHY} < ${FLYDIR}/clusters.no_paralogs.guide_tree.translation.no_masking/FBgn0041231.fasta > gr68a.phy

