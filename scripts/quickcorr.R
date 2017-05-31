#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)

dmel = './gr32a_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out'
dsim = './gr32a_regulatory-region_wiggle-lrt-conacc-droSim1.phylop_out'
allbr = './gr32a_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out'

load_scores = function(filename){
    scan(filename, skip = 1)
}

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

lbl_v = Vectorize(lbl)

getp = function(score){
    10^(-(sign(score) * score))
}

getadjp = function(pv){
    p.adjust(pv, method = 'fdr')
}

df = data.frame(dmel=load_scores(dmel),
                dsim=load_scores(dsim),
                allbr=load_scores(allbr)
                )

dflbl = df %>% mutate_all(funs(conacc = lbl_v))

scoresplot = ggplot(dflbl) +
    geom_hline(yintercept = 0, linetype = 'dashed') +
    geom_vline(xintercept = 0, linetype = 'dashed') +
    geom_point(aes(x = dmel, y = dsim,
                   col = allbr_conacc,
                   shape = allbr_conacc
                   ),
               alpha = 0.8,
               size = 3
               ) +
    scale_color_discrete(guide = FALSE) +
    guides(shape = guide_legend(title = "AllBranches")) +
    xlab("dm3 LRT scores") + ylab("droSim1 LRT scores") +
    coord_fixed() +
    theme_bw()



ggsave("conacc-scores.pdf", scoresplot)
