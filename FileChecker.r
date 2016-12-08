###
# Extract Data from DropBox
###


tutorials = c(9)
	
#Load packages ----------------------------------
require("gdata")
require("dataframes2xls")
	

#Read file and describe it
	#args = commandArgs(trailingOnly=TRUE)
	#tutorial = arg[1] #1
master.file = "C:\\Users\\ZayedLab\\Desktop\\Dropbox\\BIOL 2040 F2016 Tutorial Grades\\2016BIOL2040A (6).xls"
	
#load master class list extraxt summary info --------------------------------
master.attendance = read.xls(master.file, header=T)
master.attendance$X = master.attendance$X.1 = master.attendance$X.2 = NULL


for(tutorial in tutorials){
	print(tutorial)

# Load in marking sheets ------------------------------------------
pattern = paste("_T", tutorial, ".xlsx", sep="")
tutorial.grades.files = list.files(pattern=pattern, recursive = T)
print(paste("You are checking", length(tutorial.grades.files ), "files", sep=" "))

	concat.files = c()
	for(i in 1:length(tutorial.grades.files)){
		print(i)
		fil = read.xls(tutorial.grades.files[i])
		fil = fil[,c(1:9)]
		#Extract extra students ------------------------------------------
		additional = grep("Additional:", fil$ID) 
		fil.new = fil[additional:nrow(fil),]; fil.new = fil.new[-1,]
		fil = fil[-c(additional:nrow(fil)),]
		
		
		#Data Checks on the file ----------------------------------------
		#should be no empty cells 
		if(sum(is.na(fil)) > 0){
			print(tutorial.grades.files[i])
			stop("empty cells ")
			
		}

		#should be no absent students with marks 
		if(sum(fil$Ind[fil$AP=="A"] + fil$Grp[fil$AP=="A"]) > 0){
			print(tutorial.grades.files[i])
			stop("Absent student has a mark")
		}

		if(sum(fil.new$Ind[fil.new$AP=="A"] + fil.new$Grp[fil.new$AP=="A"]) > 0){
			print(tutorial.grades.files[i])
			stop("Absent student has a mark")
		}

		#Check Additional students against Master ----------------------------------------
		if(sum(which(!(fil.new$ID %in% master.attendance$ID))) > 0){
			print("Missing Student ID from Master")
			print(tutorial.grades.files[i])
			print(fil.new[which(!(fil.new$ID %in% master.attendance$ID)),])
				
		}

		#Add Student Information to additional ----------------------------------------
		fil.new = merge(master.attendance, fil.new, by = "ID", all.y=T)[c(1,7,8,4:6,12:14)]
		names(fil.new) = names(fil)

		fil = data.frame(rbind(fil,fil.new))
		fil$Attended = rep( tutorial.grades.files[i], nrow(fil))
		concat.files = data.frame(rbind(concat.files,fil))
	}


#ensure all students have only one mark ---------------
concat.files = concat.files[order(concat.files$ID),]
std.count = as.data.frame(table(concat.files$ID))
std.count = std.count[std.count$Freq!="1",]
num.dupl = nrow(concat.files[which(concat.files$ID %in% std.count$Var1),])/2
print(paste(num.dupl, "students with duplicate entries", sep=" "))
print(concat.files[which(concat.files$ID %in% std.count$Var1),])



concat.files = concat.files[- which(concat.files$ID %in% std.count$Var1 & concat.files$AP =="A"),] 
write.table(concat.files, file = paste("BIOL2040_MergedGrades_", tutorial, sep=""))

}






