###
# Calculate Total student marks 
###

#TODO: remove hard-coded files and add in args



#Load packages ----------------------------------
source("FileChecker.r")


#arguments -----------------------------------
Percent.Ind = 0.5
Percent.Grp  = 1 - Percent.Ind 
Total.Grp = 13
Total.Ind = 11
fin.marks = rep("NA", nrow(fil))

# Calculate contribution of Individual and Group Marks ----------------------
fin.marks = Percent.Ind * (fil$Ind/Total.Ind) + Percent.Grp * (fil$Grp/Total.Grp)

# Any Individual > Group Marks? ----------------------
if(sum((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))>1){
	high.mark.inds = which((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))
	fin.marks[high.mark.inds] = (fil$Ind[high.mark.inds]/Total.Ind)
}

# Any Individual > Group Marks? ----------------------
if(sum((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))>1){
	high.mark.inds = which((fil$Ind/Total.Ind) > (fil$Grp/Total.Grp))
	fin.marks[high.mark.inds] = (fil$Ind[high.mark.inds]/Total.Ind)
}

fil$FinPerc = fin.marks





























