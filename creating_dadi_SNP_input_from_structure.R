creating_dadi_SNP_input_from_structure <- function(working_dir,file_name,opt1,opt2) {

library(stringr)

# Throwing out error messages if any of the inputs are missing from the command line
x <- 0
error_one <- 0
error_two <- 0
error_three <- 0
error_four <- 0

killswitch <- "no"

if(missing(working_dir)) {
x <- 1
error_one <- 1
killswitch <- "yes"
}

if(missing(file_name)) {
x <- 1
error_two <- 2
killswitch <- "yes"
}

if(missing(opt1)) {
x <- 1
error_three <- 3
killswitch <- "yes"
}

if(missing(opt2)) {
x <- 1
error_four <- 4
killswitch <- "yes"
}

if(x==1) {
cat("Call the program by creating_dadi_SNP_input_from_structure(working_dir,file_name,opt1,opt2), where:\nworking_dir == pathway to the folder with your structure.tsv file e.g. \"C:/blahblahblah\" \nfile_name == the name of your structure.tsv file e.g. \"data.structure.tsv\"\nopt1 ==  \"Y\"/\"N\" - do you wish to focus on your ingroup populations rather than chosing SNPs \nwhere the state is the same over all outgroup species?\nopt2 == \"Y\"/\"N\" - do you wish to only consider SNPs where all outgroups have the same state? \n(note - you can do both opt1 and opt2)\n\nExample of input:\ngenetic_diversity_diffs(\"C:/Users/Folder/\",\"data.structure.tsv\",\"Y\",\"Y\")\n\nSpecific errors/missing inputs:\n")
}
if(error_one==1) {
cat("Sorry, I am missing a working directory pathway\nworking_dir == pathway to the folder with your structure.tsv file e.g. \"C:/blahblahblah\" \n\n")
}
if(error_two==2) {
cat("Sorry, I am missing a filename for your structure.tsv file\nfile_name == the name of your structure.tsv file e.g. \"structure.tsv.txt\"\n\n")
}
if(error_three==3) {
cat("Would you like to create a dataset arbritrarily picking one of your outgroup species for one \nSNP per locus?\nopt1== \"Y\"/\"N\"\n\n")
}
if(error_four==4) {
cat("Would you like create a dataset taking the SNP where your multiple outgroups have the same \n'ancestral' state?\nopt2== \"Y\"/\"N\"\n\n")
}


# A tab-delimited file with your sample names in the left-hand column and population/species designation in the right-hand.
# Make sure to label any of the outgroups with "outgroup" (lowercase)
print(noquote("An error message following this means your namelist.txt file is not named namelist.txt, or it isn't in the directory you specified"))
flush.console()
namelist <- as.matrix(read.table("namelist.txt"))
print(noquote("All good, I've found namelist.txt"))
flush.console()




temp <- readLines("temp")

lentemp <- length(temp)

lennamelist <- dim(namelist)[1]

outtemp <- matrix(NA,nrow=lentemp,ncol=1)

for (i in 1:lentemp) {
x <- 0
templine <- unlist(strsplit(temp[i],"\t"))
lentempline <- length(templine)
for (j in 1:lentempline) {
for (k in 1:lennamelist) {
if ((length(grep(namelist[k,2],templine[j])))>0) {
x <- 1
templine[j] <- namelist[k,1]
break
}
}
if (x==1) {break}
}
temp[i] <- paste(templine,collapse="\t")
}

write.table(temp, "tempout",quote=FALSE, col.names=FALSE,row.names=FALSE)
