filename <- readLines("file_name")
input_file <- readLines(filename)

number_of_sites <- length(unlist(strsplit(input_file[2],"\t")))-2
site_array <- c(1:number_of_sites)
site_array <- paste(c("","",site_array),collapse="\t")

output <- c(input_file[1],site_array,input_file[2:(length(input_file))])

write.table(output,"output.str",quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
