###
# Extract Data from DropBox
###

setwd("/Users/brcok/Desktop/BIOL2040_W2017/")

source("params.R")

#loop through tutorials --------------

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
			names(fil) = c("ID","LN","FN","EM","L","TUT","AP","Ind","Grp")

			#Extract extra students ------------------------------------------
			additional = grep("Additional", fil$ID) 
			
			#update ID
			fil$ID = as.numeric(as.character(fil$ID))
	


			if(length(additional) >= 1){	
			
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
			fil.new = merge(master.attendance, fil.new, by = "ID", all.y=T)[c(1:6,13:15)]
			names(fil.new) = names(fil)

			fil = data.frame(rbind(fil,fil.new))

			fil$Attended = rep( tutorial.grades.files[i], nrow(fil))
			
			concat.files = data.frame(rbind(concat.files,fil))
		

		}else{		
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

			fil$Attended = rep( tutorial.grades.files[i], nrow(fil))
			concat.files = data.frame(rbind(concat.files,fil))


		}

	}



#update AP
concat.files$AP = toupper(concat.files$AP)



#ensure all students have only one mark ---------------
concat.files = concat.files[order(concat.files$ID),]
std.count = as.data.frame(table(concat.files$ID))
std.count = std.count[std.count$Freq!="1",]
num.dupl = nrow(concat.files[which(concat.files$ID %in% std.count$Var1),])/2
print(paste(num.dupl, "students with duplicate entries", sep=" "))
print(concat.files[which(concat.files$ID %in% std.count$Var1),])



concat.files = concat.files[-which(concat.files$ID %in% std.count$Var1 & concat.files$AP == "A"),] 
write.table(concat.files, file = paste("BIOL2040_MergedGrades_", tutorial, sep=""))

}






