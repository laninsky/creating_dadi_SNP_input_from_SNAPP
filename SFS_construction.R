#Change opt1_output.txt to whatever your file is called
dadi_format <- as.matrix(read.table("opt1_output.txt"))
max_count <- as.matrix(read.table("maxcount.txt"))
folded_count <- max_count/2

SFS_length <- 0

for (i in 1:((dim(folded_count)[2])-1)) {
  for (j in (i+1):(dim(folded_count)[2])) {
    SFS_length <- SFS_length+(folded_count[i]*folded_count[j])
  }
}

dadi_format_title <- length(dadi_format[1,]
pop_names <- dadi_format[1,4:(((dadi_format_title-6)/2)+2)]

to_remove <- NULL

for (j in 1:length(pop_names)) {
  pop_column <- which(dadi_format[1,]==pop_names[j])
  for (i in 2:(dim(dadi_format)[1])) {
    if(sum(as.numeric(dadi_format[i,pop_column]))<max_count[j]) {
      to_remove <- c(to_remove,i)
    }
  }
}

to_remove <- unique(to_remove)

temp_dadi_format <- dadi_format[-to_remove,]

