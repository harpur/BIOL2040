
###
# Master Merger
###

#TODO: remove hard-coded files and add in args

#load paramaters --------------
source("params.R")



master.merge = master.attendance
for(tutorial in tutorials){
	print(tutorial)
#Load in Compiled Grades and Marks ---------------------------------
fil = read.table(file = paste("BIOL2040_MergedGrades_Marked_", tutorial, sep=""))
fil = fil[c(1,7:9,11)]
master.merge = merge(master.merge, fil, all = T, by = "ID")

}

write.csv(master.merge, file = "BIOL2040Grades", row.names=F, quote=F)

 



#following is hand-filtering
	#remove all "NA" name none were on any version of the class list
	#add excused absences with NG


#reload file
master.merge =  read.xls("BIOL2040_T1_T3.xlsx", header=T)



#mung data

master.merge  = as.matrix(master.merge )
master.merge [is.na(master.merge )] = 0
master.merge  = data.frame(master.merge )

master.merge$lenAbs = apply(master.merge[-c(1:6)], 1, function(x) length(x[which(x=="A")]))
master.merge$final = apply(master.merge[grep("FinPerc",names(master.merge))], 1, function(x) mean(as.numeric(x), na.rm=T))


write.csv(master.merge, file = "BIOL2040Grades_T1_T2_T3.csv", row.names=F, quote=F)

 



#dropped students
master.merge[master.merge$tutorial=="#N/A",]






write.csv(master.merge, file = "BIOL2040Grades", row.names=F, quote=F)

 



#following is hand-filtering
	#remove all "NA" name none were on any version of the class list
	#add excused absences

#reload file
grd =  read.xls("BIOL2040_T1_T3.xlsx", header=T)

#checked boxplots of distribution between tutorials -TUT5 is low for all...Bianaca
#calcualted final percent as the best of 9 tutorials for each person.

#df = grd[c(1:6)]
#grd2 = grd[grep("^FinPerc*",names(grd))]


#extract the mean of the top N rows, excluding NA's

	#head(apply(grd2, 1, max,na.rm=T))
	#test  = c(1,2,3,4,5,6,7,8,9)
	#mean(test[-which(min(test)[1])])







#top N grds
grd$final = apply(grd[grep("FinPerc",names(grd))], 1, function(x) mean(as.numeric(sort(x)[-1])))





#head(grd)grd$fin17 = grd$final*0.17



write.csv(grd, file = "BIOL2040Grades17_up.csv", row.names=F, quote=F)









