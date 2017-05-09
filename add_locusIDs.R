filename <- readLines("file_name")
input_file <- readLines(filename)

number_of_sites <- length(unlist(strsplit(input_file[2],"\t")))
