#!/usr/bin/env Rscript

library(ggbeeswarm)
library(dplyr)
library(ggplot2)

dm3conaccallbr = "./gr32a_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out"

scores = scan(dm3conaccallbr, skip = 1)
conacc = sign(scores)
pvals = 10^(-(conacc * scores))  # 1 * pos = pos, -1 * neg = pos, 0 * 0 = 0
adjp = p.adjust(pvals, method = "fdr")

lbl = function(sn){
    if(sn >= 0){
        l = "Conservation"
    } else if(sn < 0){
        l = "Acceleration"
    }# else {
     #   l = "Neutral"
    #}
    return(l)
}

df = data.frame(scores = scores,
                pvals = pvals,
                adjp = adjp,
                conacc = Vectorize(lbl)(scores)
                )
plotp = ggplot(df) +
    geom_violin(aes(y = pvals, x = conacc, fill = conacc),
                scale = 'count'
                ) +
    geom_beeswarm(aes(x = conacc, y = pvals), cex = 0.2, alpha = 0.1) +
    stat_summary(aes(x = conacc, y = pvals), fun.y = median,
                 geom = 'point', pch = 18, size = 3,
                 col = 'white', alpha = 0.5
                 ) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
    scale_fill_brewer(palette = "Set2") +
    coord_cartesian(ylim = c(0,1)) +
    theme_bw() +
    xlab("") + ylab("LRT P-values")


ggsave("allbr-conacc-p.pdf", plotp)
