#!/usr/bin/env Rscript
# Rename a column in R
args<-commandArgs(TRUE)  #receive file name through command line arg
#add error handling
tryCatch(
{
assign("file1",data<-read.csv(args[1], header = T),envir=.GlobalEnv) #read file and assign in to a global var
},
warning = function(w)
{
	print("caused a warning\n")   #messages in case of warning
	message("Here is the original warning message:")
	message(w)
	return(NULL)
},
error = function(err)
{
print("Could not find the file mentioned in the commandline arguement\n")  #messages in case of error
message("Here is the original message:")
message(err)
return(NA)  #choose a return value in case of error
},
finally={
	print("read file successfully\n")
}
)
names(file1)[names(file1)=="v1"]<-"normal"   #renaming the columns
names(file1)[names(file1)=="v2"]<-"poisson"
names(file1)[names(file1)=="v3"]<-"guass"
write.csv(file1,file=args[1])	#rewrite the file


