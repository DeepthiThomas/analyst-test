#!/usr/bin/env Rscript
args<-commandArgs(TRUE)
x<-read.csv(args[1], header = T)
mx<-mean(x$v2)
medx<-median(x$v2)
hist(x$v2)
abline(v = mx, col = "blue", lwd = 1)
abline(v = medx, col = "red", lwd = 1)

