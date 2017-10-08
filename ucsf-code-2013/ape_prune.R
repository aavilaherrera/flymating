#!/usr/bin/Rscript

require(ape)
args = commandArgs(TRUE)

if(length(args) < 3){
	stop("usage: ./ape_prune.R in.topo leaf_list.keep out.topo")
}

tin = args[1]
leaf_list = args[2]
tout = args[3]

`%ni%` <- Negate(`%in%`)

tree = read.tree(tin)
keep_these = as.vector(read.table(leaf_list, sep='\t')[,1])

prune_these = tree$tip.label[tree$tip.label %ni% keep_these]

tree = drop.tip(tree, prune_these)

write.tree(tree, tout)

