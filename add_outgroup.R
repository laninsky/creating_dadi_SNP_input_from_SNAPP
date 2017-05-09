filename <- readLines("file_name")
input_file <- readLines(filename)

temp <- (unlist(strsplit(input_file[3],"\t")))
temp[1] <- paste(temp[1],"_outgroup",sep="")
temp[2] <- "outgroup"
temp <- paste(temp,collapse="\t")

output <- c(input_file[1:2],temp,temp,input_file[3:(length(input_file))])

write.table(output,"output_outgroup.str",quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
