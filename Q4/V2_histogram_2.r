#!/usr/bin/env Rscript
args<-commandArgs(TRUE) #receive file through commandline
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
hist(file1$v2)
medx<-median(file1$v2)
abline(v = medx, col = "red", lwd = 1)
mx<-mean(file1$v2)
abline(v = mx, col = "blue", lwd = 1)

#abline(v = mx, col = "blue", lwd = 1)
#abline(v = medx, col = "red", lwd = 1)

