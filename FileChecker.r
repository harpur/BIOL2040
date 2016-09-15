###
# Extract Data from DropBox
###






#Read file and describe it

fil.name =c()

setwd("C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\Section 6 Brock")



#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")

#load master class list extraxt summary info --------------------------------
master.attendance = read.xls("C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\BIOLOGY 2040 FALL 2016.xls", header=T)
master.attendance$X = master.attendance$X.1 = master.attendance$X.2 = NULL

# Load in marking sheet ------------------------------------------
fil = read.xls("BIOL 2040 F2016 Class List _T6.xlsx")

#Extract extra students ------------------------------------------
additional = grep("Additional:", fil$ID) 
fil.new = fil[additional:nrow(fil),]; fil.new = fil.new[-1,]
fil = fil[-c(additional:nrow(fil)),]
	
	
#Data Checks on the file ----------------------------------------
#should be no empty cells 
if(sum(is.na(fil)) > 0){
	stop("empty cells")
}

#should be no absent students with marks 
if(sum(fil$Ind[fil$AP=="A"] + fil$Grp[fil$AP=="A"]) > 0){
	stop("Absent student has a mark")
}

if(sum(fil.new$Ind[fil.new$AP=="A"] + fil.new$Grp[fil.new$AP=="A"]) > 0){
	stop("Absent student has a mark")
}

#Check Additional students against Master ----------------------------------------
if(sum(fil.new$ID %in% master.attendance$ID) > 0){
	print("Missing Student ID from Master")
	print(fil.name)
	fil.new[which(!(fil.new$ID %in% master.attendance$ID)),]
}

#Add Student Information to additional ----------------------------------------
fil.new = merge(master.attendance, fil.new, by = "ID", all.y=T)[c(1,7,8,4:6,12:14)]
names(fil.new) = names(fil)

























