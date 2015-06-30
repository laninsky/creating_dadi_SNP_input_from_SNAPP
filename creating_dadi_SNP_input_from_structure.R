creating_dadi_SNP_input_from_structure <- function(working_dir,file_name,opt1,opt2) {

library(stringr)

##############TO ADD: SPECIFY CUSTOM NAMELIST.TXT NAME INSTEAD OF IT HAVING TO BE NAMELIST.TXT

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

#The next little bit is massaging our data so we know which rows are from what population etc etc
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
inputmatrixdata <- inputmatrixdata[order(inputmatrixdata[,1]),]

pop_names <- unique(inputmatrixdata[,1])
pop_names <- pop_names[which(pop_names!="outgroup")]

output <- t(as.matrix(c("ingroup","outgroup","Allele1",pop_names,"Allele2",pop_names,"locus","SNP")))

pop_coordinates <- rbind(inputmatrixdata[2,1],2)
i <- 2

while (i <= (matrixlength-1)) {
x <- i+1
while((x<=(matrixlength-1))&&(inputmatrixdata[i,1]==inputmatrixdata[x,1])) {
x <- x + 1
}
if(x<=(matrixlength-1)){
pop_coordinate_temp <- rbind(inputmatrixdata[x,1],(x+1))
pop_coordinates <- cbind(pop_coordinates,pop_coordinate_temp)
i <- x
} else {
i <- matrixlength
}
}

inputmatrix <- rbind(inputmatrixheader,inputmatrixdata)
matrixwidth <- dim(inputmatrix)[2]
matrixlength <- dim(inputmatrix)[1]

no_pops <- dim(pop_coordinates)[2]

rm(pop_names)
rm(inputmatrixdata)
rm(inputmatrixheader)
rm(pop_coordinate_temp)

print(noquote("We've got the data into a format that we can start manipulating to get the SNP frequencies from"))
print(noquote(""))
flush.console()

print(noquote("We've got the data in a format that we can start manipulating to get the SNP frequencies from"))
print(noquote(""))
flush.console()

outgroupcol <- which(pop_coordinates[1,]=="outgroup")

# Option one, here we go
if (opt1=="yes") {
print(noquote("You've said you'd like to do opt1 - maximizing ingroup data when chosing the SNP from each locus. Here we go with that"))
print(noquote(""))
flush.console()

i <- 4
while (i <= matrixwidth) {
x <- i+1
while((x<=matrixwidth)&&(inputmatrix[1,i]==inputmatrix[1,x])) {
x <- x + 1
}

if(x<=(matrixwidth+1)){
y <- i
j <- 1
temp <- matrix(0,ncol=(x-i),nrow=6)

while(y < x) {
temp1 <- matrix(0,ncol=no_pops,nrow=4)
temp[1,j] <- y
for (k in 1:no_pops) {
if(k==no_pops) {

temp1[1,k] <- temp1[1,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,y]==1)
temp1[2,k] <- temp1[2,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,y]==2)
temp1[3,k] <- temp1[3,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,y]==3)
temp1[4,k] <- temp1[4,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,y]==4)
temp[2,j] <- temp[2,j] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,y]==0)
} else {
temp1[1,k] <- temp1[1,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),y]==1)
temp1[2,k] <- temp1[2,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),y]==2)
temp1[3,k] <- temp1[3,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),y]==3)
temp1[4,k] <- temp1[4,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),y]==4)
temp[2,j] <- temp[2,j] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),y]==0)
}
}

sumallele <- matrix(0,ncol=1,nrow=4)
sumallele[1,1] <- sum(temp1[1,])-temp1[1,outgroupcol] 
sumallele[2,1] <- sum(temp1[2,])-temp1[2,outgroupcol] 
sumallele[3,1] <-  sum(temp1[3,])-temp1[3,outgroupcol]
sumallele[4,1] <-  sum(temp1[4,])-temp1[4,outgroupcol]

temp[3,j] <- sumallele[1,1]
temp[4,j] <- sumallele[2,1]
temp[5,j] <- sumallele[3,1]
temp[6,j] <- sumallele[4,1]

y <- y+1
j <- j+1
}

temp2 <- NULL
tempwidth <- dim(temp)[2]
for (m in 1:tempwidth) {
if (sum(temp[3:6,m]==0)==2) {
tempster <- rbind(m,as.matrix(temp[,m]))
temp2 <- cbind(temp2,tempster)
}
}

if (!(is.null(temp2))) {
prop <- 1
n <- which.min(temp2[3,])
tempwidth <- dim(temp2)[2]
if(min(temp2[3,])==max(temp2[3,])) {
for (m in 1:tempwidth) {
proptest <- max(temp2[4:7,m])/sum(temp2[4:7,m])
if (proptest < prop) {
prop <- proptest
n <- m
}
}
} else {
temp3 <- NULL
if (sum(temp2[3,]==min(temp2[3,]))>1) {
for (m in 1:tempwidth) {
if (temp2[3,m]==min(temp2[3,])) {
tempster <- rbind(as.matrix(temp2[,m]))
temp3 <- cbind(temp3,tempster)
}
}
temp2 <- temp3
tempwidth <- dim(temp2)[2]
if(min(temp2[3,])==max(temp2[3,])) {
for (m in 1:tempwidth) {
proptest <- max(temp2[4:7,m])/sum(temp2[4:7,m])
if (proptest < prop) {
prop <- proptest
n <- m
}
}
}
}
}

templocus <- inputmatrix[1,temp2[2,n]]
tempSNP <- temp2[1,n]

temp1 <- matrix(0,ncol=no_pops,nrow=4)
for (k in 1:no_pops) {
if(k==no_pops) {
temp1[1,k] <- temp1[1,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,temp2[2,n]]==1)
temp1[2,k] <- temp1[2,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,temp2[2,n]]==2)
temp1[3,k] <- temp1[3,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,temp2[2,n]]==3)
temp1[4,k] <- temp1[4,k] + sum(inputmatrix[(pop_coordinates[2,k]):matrixlength,temp2[2,n]]==4)
} else {
temp1[1,k] <- temp1[1,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),temp2[2,n]]==1)
temp1[2,k] <- temp1[2,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),temp2[2,n]]==2)
temp1[3,k] <- temp1[3,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),temp2[2,n]]==3)
temp1[4,k] <- temp1[4,k] + sum(inputmatrix[(pop_coordinates[2,k]):(as.numeric(pop_coordinates[2,(k+1)])-1),temp2[2,n]]==4)
}
}

tempoutgroup <- which.max(temp1[,outgroupcol])
sumallele <- matrix(0,ncol=1,nrow=4)
sumallele[1,1] <- sum(temp1[1,])-temp1[1,outgroupcol] 
sumallele[2,1] <- sum(temp1[2,])-temp1[2,outgroupcol] 
sumallele[3,1] <-  sum(temp1[3,])-temp1[3,outgroupcol]
sumallele[4,1] <-  sum(temp1[4,])-temp1[4,outgroupcol]
tempmajallele <- which.max(sumallele[,1])

tempallele1 <- t(as.matrix(temp1[tempmajallele,-outgroupcol]))

sumallele[tempmajallele,] <- 0
tempminallele <- which.max(sumallele[,1])
tempallele2 <- t(as.matrix(temp1[tempminallele,-outgroupcol]))

toadd <- cbind(tempmajallele,tempoutgroup,tempmajallele,tempallele1,tempminallele,tempallele2,templocus,tempSNP)
output <- rbind(output,toadd)
}
}
i <- x
}

rm(i)               
rm(j)               
rm(k)               
rm(m)              
rm(matrixlength)    
rm(matrixwidth)     
rm(n)           
rm(prop)           
rm(proptest)        
rm(sumallele)       
rm(temp)            
rm(temp1)           
rm(temp2)          
rm(temp3)           
rm(tempallele1)     
rm(tempallele2)     
rm(templocus)       
rm(tempmajallele)  
rm(tempminallele)   
rm(tempoutgroup)    
rm(tempSNP)         
rm(tempster)        
rm(tempwidth)      
rm(toadd)           
rm(x)               
rm(y) 

outputlength <- dim(output)[1]
output[2:outputlength,1:2] <- replace(output[2:outputlength,1:2],output[2:outputlength,1:2]==1,"-A-")
output[2:outputlength,1:2] <- replace(output[2:outputlength,1:2],output[2:outputlength,1:2]==2,"-C-")
output[2:outputlength,1:2] <- replace(output[2:outputlength,1:2],output[2:outputlength,1:2]==3,"-G-")
output[2:outputlength,1:2] <- replace(output[2:outputlength,1:2],output[2:outputlength,1:2]==4,"-T-")

output[2:outputlength,3] <- replace(output[2:outputlength,3],output[2:outputlength,3]==1,"A")
output[2:outputlength,3] <- replace(output[2:outputlength,3],output[2:outputlength,3]==2,"C")
output[2:outputlength,3] <- replace(output[2:outputlength,3],output[2:outputlength,3]==3,"G")
output[2:outputlength,3] <- replace(output[2:outputlength,3],output[2:outputlength,3]==4,"T")

output[2:outputlength,(no_pops*2)] <- replace(output[2:outputlength,(no_pops*2)],output[2:outputlength,(no_pops*2)]==1,"A")
output[2:outputlength,(no_pops*2)] <- replace(output[2:outputlength,(no_pops*2)],output[2:outputlength,(no_pops*2)]==2,"C")
output[2:outputlength,(no_pops*2)] <- replace(output[2:outputlength,(no_pops*2)],output[2:outputlength,(no_pops*2)]==3,"G")
output[2:outputlength,(no_pops*2)] <- replace(output[2:outputlength,(no_pops*2)],output[2:outputlength,(no_pops*2)]==4,"T")

write.table(output,"opt1_output.txt", sep="\t",quote=FALSE, row.names=FALSE,col.names=FALSE)
}



###########

print(x)
pop_coordinate_temp <- rbind(inputmatrixdata[x,1],x)
pop_coordinates <- cbind(pop_coordinates,pop_coordinate_temp)
i <- x
} else {
i <- matrixlength
}
}






while (inputmatrix[1,i]==inputmatrix[1,(i+x)]) {
x <- x+1
}




i <- i + x }


4:

write.table(temp, "tempout",quote=FALSE, col.names=FALSE,row.names=FALSE)
