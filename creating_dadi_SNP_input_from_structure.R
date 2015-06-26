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

#Checking status of working directory
print(noquote("STEP ONE: Loading in all the variables"))
print(noquote(""))
print(noquote("An error message after this indicates your working directory is not valid"))
flush.console()
setwd(working_dir)
print(noquote("Not to worry, your working directory IS valid! I've successfully set the working directory"))
print(noquote(""))
flush.console()

#Checking status of structure file
print(noquote("An error message after this indicates your structure.tsv file is not located in the directory you listed"))
flush.console()
input <- readLines(file_name)
print(noquote("Not to worry, your file IS located in the directory!"))
print(noquote(""))
flush.console()

# A tab-delimited file with your sample names in the left-hand column and population/species designation in the right-hand.
# Make sure to label any of the outgroups with "outgroup" (lowercase)
print(noquote("An error message following this means your namelist.txt file is not named namelist.txt, or it isn't in the directory you specified"))
flush.console()
namelist <- as.matrix(read.table("namelist.txt"))
print(noquote("All good, I've found namelist.txt"))
flush.console()

rm(error_one)
rm(error_two)
rm(x)
rm(error_four)
rm(error_three)
rm(file_name)
rm(killswitch)
rm(working_dir)

pop_names <- unique(namelist[,2])
pop_names <- pop_names[which(pop_names!="outgroup")]

output <- t(as.matrix(c("ingroup","outgroup","Allele1",pop_names,"Allele2",pop_names,"locus","SNP")))

lengthinput <- length(input)
input <- input[2:lengthinput]

matrixwidth <- length(unlist(strsplit(input[1],"\t")))

inputmatrix <- matrix("",ncol=matrixwidth,nrow=(lengthinput-1))

for (i in 1:(lengthinput-1)) {
inputmatrix[i,] <- unlist(strsplit(input[i],"\t"))
}

rm(input)
rm(lengthinput)
rm(matrixwidth)

namelist <- rbind(namelist,namelist)
namelist <- namelist[order(namelist[,1]),]

matrixlength <- dim(inputmatrix)[1]
inputmatrixheader <- cbind("",t(inputmatrix[1,]))
inputmatrixdata <- inputmatrix[2:matrixlength,]

inputmatrixdata <- inputmatrixdata[order(inputmatrixdata[,1]),]

if(all(inputmatrixdata[,1]==namelist[,1])==FALSE) {
stop("Your namelist.txt and structure.tsv files do not have the same taxa listed. Please fix your files and try again")
}

inputmatrixdata <- cbind(namelist[,2],inputmatrixdata)

inputmatrix <- rbind(inputmatrixheader,inputmatrixdata)



write.table(temp, "tempout",quote=FALSE, col.names=FALSE,row.names=FALSE)
