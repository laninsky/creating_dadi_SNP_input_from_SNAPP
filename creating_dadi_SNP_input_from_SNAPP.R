library(stringr)

# A tab-delimited file with your sample names in the left-hand column and population/species designation in the right-hand.
# Make sure to label any of the outgroups with "outgroup"

namelist <- as.matrix(read.table("namelist.txt"))

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
