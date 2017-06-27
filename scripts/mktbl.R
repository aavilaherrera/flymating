#!/usr/bin/env Rscript

library(tidyverse)
library(magrittr)

# run from anywhere hack
args <- commandArgs(trailingOnly = TRUE)
if(length(args)){
  setwd(args[1])
}

# ---- beds (regions) ----
consel_bed <- read_tsv(
  "./coords/dm6-allbr-consel27.bed.gz",
  col_names = c(
    "CHROM", "START", "STOP",
    "NAME", "SCORE"
  )
)
adjacent_bed <- read_tsv(
  "./coords/661.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
) %>% filter(NAME == "upstrm_661b")  # filter no longer needed
cds_bed <- read_tsv(
  "./coords/cds_exons.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
)
utr5_bed <- read_tsv(
  "./coords/utr5.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
)
utr3_bed <- read_tsv(
  "./coords/utr3.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
)
introns_bed <- read_tsv(
  "./coords/introns.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
)
intrgn_bed <- read_tsv(
  "./coords/intergenic.bed",
  col_names = c("CHROM", "START", "STOP", "NAME")
)

# ---- wiggles ----
browser_phylop_allbr <- read_tsv(
  "./tracks/dm6-allbr-phylop27.wig.gz",
  comment = "#",
  skip = 2,
  col_names = c("pos", "browser_phylop_allbr")
)
phylop_allbr <- read_tsv(
  "./phylop/allbr-phylop27.wig",
  comment = "#",
  skip = 1,
  col_names = c("phylop_allbr")
)
phylop_dmel <- read_tsv(
  "./phylop/dm6-phylop27.wig",
  comment = "#",
  skip = 1,
  col_names = c("phylop_dmel")
)
phylop_dsim <- read_tsv(
  "./phylop/droSim1-phylop27.wig",
  comment = "#",
  skip = 1,
  col_names = c("phylop_dsim")
)

# ---- functions ----
isInBed <- function(pos1_v, bed){
  b <- nrow(bed)
  v <- length(pos1_v)
  s <- c("START", "STOP")
  m <- vapply(
    1:b,
    function(bi){
      findInterval(pos1_v - 1, bed[bi, s]) == 1
    },
    rep(0, v)
  )
  rowSums(m) > 0
}

# ---- main ----
phylop_tbl <- bind_cols(
  browser_phylop_allbr,
  phylop_allbr,
  phylop_dmel,
  phylop_dsim
) %>%
  mutate(
    isConsEl = isInBed(pos, consel_bed),
    is661 = isInBed(pos, adjacent_bed),
    isCDS = isInBed(pos, cds_bed),
    isUTR5 = isInBed(pos, utr5_bed),
    isUTR3 = isInBed(pos, utr3_bed),
    isIntron = isInBed(pos, introns_bed),
    isIntergenic = isInBed(pos, intrgn_bed)
  )

write_tsv(phylop_tbl, "../results/phylop.tsv")
