
###
# Calculate Total student marks 
###

#TODO: remove hard-coded files and add in args

tutorials = c(9)

#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")

#Read file and describe it
#tutorial = arg[1] #1
master.file = "C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\2016BIOL2040A (6).xls"


for(tutorial in tutorials){
	print(tutorial)

#Run File Checks ----------------------------------------

#FileChecker.r

#Load in Compiled Grades and Marks ---------------------------------
fil = read.table(file = paste("BIOL2040_MergedGrades_", tutorial, sep=""))
marks = read.xls("TotalMark.xls")
	
#Load in Compiled Grades and Marks ---------------------------------
fil = read.table(file = paste("BIOL2040_MergedGrades_", tutorial, sep=""))
marks = read.xls("TotalMark.xls")
	
sect = paste("T", tutorial, sep="")	
	
	
#arguments -----------------------------------
Percent.Ind = 0.5 #this is hard set until otherwise changed
Percent.Grp  = 1 - Percent.Ind 
Total.Ind = marks[2][grep(sect,marks$tut),]
Total.Grp = marks[3][grep(sect,marks$tut),]
fin.marks = rep("NA", nrow(fil))

# Calculate contribution of Individual and Group Marks ----------------------
fin.marks = Percent.Ind * (fil$Ind/Total.Ind) + Percent.Grp * (fil$Grp/Total.Grp)

# Any Individual > Group Marks? ----------------------
if(sum((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))>1){
	high.mark.inds = which((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))
	fin.marks[high.mark.inds] = (fil$Ind[high.mark.inds]/Total.Ind)
}


fil$FinPerc = fin.marks 
names(fil)[11] = paste("FinPerc", tutorial, sep="")
names(fil)[c(7,8,9)] = paste(names(fil)[c(7,8,9)], tutorial, sep="")

write.table(fil, file = paste("BIOL2040_MergedGrades_Marked_", tutorial, sep=""))

}
























