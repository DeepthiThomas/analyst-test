#!/usr/bin/env Rscript
# Rename a column in R
args<-commandArgs(TRUE)
data<-read.csv(args[1], header = T)
names(data)[names(data)=="v1"]<-"normal"
names(data)[names(data)=="v2"]<-"poisson"
names(data)[names(data)=="v3"]<-"guass"
write.csv(data,file='renamedFile.csv')
