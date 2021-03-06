###
# Mark Pusher
###



#Load packages ----------------------------------
source("params.R")

#Run File Checks ----------------------------------------



#Load in Compiled Grades and Marks ---------------------------------
marks = read.xls("TotalMark.xlsx")
	
	
for(tutorial in tutorials){
	print(tutorial)
	
		
#Load in Compiled Grades and Marks ---------------------------------
fil = read.table(file = paste("BIOL2040_MergedGrades_", tutorial, sep=""))
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

	
}	
	
	
	
	
	
	
	
	
	
	
	
	
#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")



















#load master class list extraxt summary info --------------------------------
master.attendance = read.xls("C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\BIOLOGY 2040 FALL 2016.xls", header=T)






#Check against Master ----------------------------------------
merge.master = merge(fil, master.attendance, by = c("ID"), all.y=T)

table(merge.master$TUT.x) 























#change directory to working -----------------------------
setwd("C:\\Users\\ZayedLab\\Desktop\\Sync\\Admin_AGSBS\\BIOL2040_W_2015\\Tutorial 9\\")

#Load master class list ----------------------------------
master = read.table(file="MasterList.txt",header=T)

assembled = c()
for (i in dir(pattern="Tutorial [-]*")){
	fil = read.xls(i)
	fil = fil[c(1:6)]
	print(i)
	if(length(grep("OTHER", fil$X.1))==1){
		other.fil = fil[1+grep("OTHER", fil$X.1):(nrow(fil)-1),] 
		fil = fil[-c(grep("OTHER", fil$X.1):nrow(fil)),]
		fil = fil[-c(2,3,4)]
		other.fil = other.fil[-c(2,3,4)]
		fil = rbind(fil, other.fil)
		
		fil$TUT = rep(gsub(".*[-]","",i), nrow(fil))
		fil$TUT = gsub("[.]xls","",fil$TUT)
		
		names(fil)=c("ID", "Attendance","Grade", "Section")
		assembled =  rbind(fil, assembled)
		
	}else{
		#fil = fil[-c(grep("OTHER", fil$X.1):nrow(fil)),]
		fil = fil[-c(2,3,4)]
		
		fil$TUT = rep(gsub(".*[-]","",i), nrow(fil))
		fil$TUT = gsub("[.]xls","",fil$TUT)
		
		
		names(fil)=c("ID", "Attendance","Grade", "Section")
		assembled =  rbind(fil, assembled)
		}
	}

	
	
#Data Checks 1: Went to wrong tutorial ----------------------------------

assembled$ID = as.character(assembled$ID)
lens = aggregate(assembled$ID, by = list(assembled$ID),length)

dbld = assembled[which(assembled$ID %in% lens$Group.1[lens$x>1]),]
if(length(dbld$ID[dbld$Attendance=="A"]) == length(dbld$ID[dbld$Attendance=="P"])){
	assembled = assembled[-which(assembled$ID %in% lens$Group.1[lens$x>1]),]
	dbld = dbld[dbld$Attendance =="P",]
	assembled = rbind(dbld, assembled)
}else{
	print("Danger, Wil Robinson, Danger!")
}




# Merge the Data ----------------------------------
	#This will fail if SSID is incorrect.
test = merge(master, assembled, by = "ID", all.x=T)
test[!complete.cases(test),]
sec = test$Section

#test$Section = paste(test$Section, collapse="",sep="")

#didn't attend?
#          ID Last_name First_name Tutorial_section Attendance Grade Section
#36 212570016       Cha  Joon_Hyuk           TUTR05       <NA>    NA    <NA>
#79 213168653      Zaid       Ayad           TUTR05       <NA>    NA    <NA>



#51, 57

# Ouput the Data ----------------------------------
write.table(test, file="Tutorial7Assembled", row.names=F,col.names=T, quote=F, sep="\t")





