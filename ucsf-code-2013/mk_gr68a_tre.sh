#!/bin/bash
# gr68a fasta in clusters.no_paralogs.guide_tree.cds.no_masking/FBgn0041231.fasta

grep '>' clusters.no_paralogs.guide_tree.cds.no_masking/FBgn0041231.fasta | tr -d '>' > gr68a.leaves

../ape_prune.R fly_tree.tre gr68a.leaves gr68a_tree.tre

NUM_LEAVES="$(($(grep -o ',' gr68a_tree.tre | wc -l) + 1))"
(echo "  ${NUM_LEAVES} 1"; cat gr68a_tree.tre) > tmp

mv tmp gr68a_tree.tre




