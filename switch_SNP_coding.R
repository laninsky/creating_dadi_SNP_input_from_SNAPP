
setwd("C:/Users/Alana/Downloads") # Change to wherever your file is
input <- as.matrix(read.table("md10mc4110gbs_HF_InGrp.str"))

# Replacing your 0-3 and -9 missing numbering with 1-4 and 0 for missing data

for (i in 1:(dim(input)[1])) {
temp <- which(grepl(3, input[i,3:(dim(input)[2])])==TRUE)+2
input[i,temp] <- 4

temp <- which(grepl(2, input[i,3:(dim(input)[2])])==TRUE)+2
input[i,temp] <- 3

temp <- which(grepl(1, input[i,3:(dim(input)[2])])==TRUE)+2
input[i,temp] <- 2

temp <- which(grepl(0, input[i,3:(dim(input)[2])])==TRUE)+2
input[i,temp] <- 1

temp <- which(grepl(-9, input[i,3:(dim(input)[2])])==TRUE)+2
input[i,temp] <- 0
}
