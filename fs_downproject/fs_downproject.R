file_name <- as.matrix(read.table("file_name"))
file <- as.matrix(read.table(file_name[1,1]))
no_of_pops <- (length(file[1,])-6)/2

maxcounts <- matrix(NA,ncol=no_of_pops,nrow=1)
for (i in 1:no_of_pops) {
maxcounts[1,i] <- max(max(as.numeric(file[2:(dim(file)[1]),(i+3)])),max(as.numeric(file[2:(dim(file)[1]),(i+4+no_of_pops)])))
}

array_expression <- vector(mode="list", length=no_of_pops)
for (i in 1:no_of_pops) {
  array_expression[[i]] <- c(1:maxcounts[1,i])
}

pop_combinations <- expand.grid(array_expression)

write.table("fs_combos.txt",quotes=FALSE,row.names=FALSE,col.names=FALSE)
  
