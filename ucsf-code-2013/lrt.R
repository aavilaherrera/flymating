#!/usr/bin/Rscript
# likelihood ratio test

args = commandArgs(TRUE)

if(length(args) < 2 ){
	usage="usage:lrt.R null_lnL alt_lnL"
	stop(usage)
}

null_lnl = as.numeric(args[1])
alt_lnl = as.numeric(args[2])

D = 2*(alt_lnl - null_lnl)
print(pchisq(D, 2, lower.tail=FALSE))



