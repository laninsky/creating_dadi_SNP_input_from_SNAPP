
setwd("C:/Users/Alana/Downloads") # Change to wherever your file is
input <- readLines("md10mc4110gbs_HF_InGrp.str")

# Replacing your 0-3 and -9 missing numbering with 1-4 and 0 for missing data

for (i in 3:length(input)) {
temp <- unlist(strsplit(input[i],"\t"))
  
temp_replace <- which(grepl(3, temp[3:length(temp)])==TRUE)+2
temp[temp_replace] <- 4

temp_replace <- which(grepl(2, temp[3:length(temp)])==TRUE)+2
temp[temp_replace] <- 3

temp_replace <- which(grepl(1, temp[3:length(temp)])==TRUE)+2
temp[temp_replace] <- 2

temp_replace <- which(grepl(0, temp[3:length(temp)])==TRUE)+2
temp[temp_replace] <- 1

temp_replace <- which(grepl(-9, temp[3:length(temp)])==TRUE)+2
temp[temp_replace] <- 0

temp <- paste(temp,collapse="\t")

input[i] <- temp
  
}

write.table(input,"output_0_4.str",quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)

