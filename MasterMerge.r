
###
# Master Merger
###

#TODO: remove hard-coded files and add in args

tutorials = c(1:3)

#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")

#Read file and describe it
#tutorial = arg[1] #1
master.file = "C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\2016BIOL2040A (6).xls"
master.attendance = read.xls(master.file, header=T)
master.attendance$X = master.attendance$X.1 = master.attendance$X.2 = NULL

master.merge = master.attendance
for(tutorial in tutorials){
	print(tutorial)
#Load in Compiled Grades and Marks ---------------------------------
fil = read.table(file = paste("BIOL2040_MergedGrades_Marked_", tutorial, sep=""))
fil = fil[c(1,7:9,11)]
master.merge = merge(master.merge, fil, all = T, by = "ID")

}

write.table(master.merge, file = "BIOL2040Grades", row.names=F, quote=F)

 




















