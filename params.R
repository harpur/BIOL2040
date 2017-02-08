
setwd("/Users/brcok/Desktop/BIOL2040_W2017/")


tutorials = c(1,2)
	
#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")
	

#Read file and describe it
	#args = commandArgs(trailingOnly=TRUE)
	#tutorial = arg[1] #1
master.file = "master.xlsx"
	
#load master class list extraxt summary info --------------------------------
master.attendance = read.xls(master.file, header=T)
master.attendance$X = master.attendance$X.1 = master.attendance$X.2 = NULL
names(master.attendance)[1] = c("ID")