#Change opt1_output.txt to whatever your file is called
dadi_format <- as.matrix(read.table("opt1_output.txt"))
max_count <- as.matrix(read.table("maxcount.txt"))
folded_count <- max_count/2

dadi_format_title <- length(dadi_format[1,])
pop_names <- dadi_format[1,4:(3+(dim(max_count)[2]))]
no_pops <- length(pop_names)

SFS_length <- prod(max_count)

to_remove <- NULL

for (j in 1:no_pops) {
  pop_column <- which(dadi_format[1,]==pop_names[j])
  for (i in 2:(dim(dadi_format)[1])) {
    if(sum(as.numeric(dadi_format[i,pop_column]))<max_count[j]) {
      to_remove <- c(to_remove,i)
    }
  }
}

to_remove <- unique(to_remove)

temp_dadi_format <- dadi_format[-to_remove,]

SFS_original <- matrix(0,ncol=SFS_length,nrow=1)
                            
for (i in 2:(dim(temp_dadi_format)[1])) {
  if ((sum(as.numeric(temp_dadi_format[i,4:(3+no_pops)]))) < (sum(as.numeric(temp_dadi_format[i,(3+no_pops+2):(3+no_pops+1+no_pops)])))) {
      x <- 3    
    } else {
      x <- 4+no_pops 
    }
  for (j in 1:(no_pops-1)) {
    j_pop <- as.numeric(temp_dadi_format[i,(j+x)])
     for (k in (j+1):(length(pop_names))) {
      k_pop  <- as.numeric(temp_dadi_format[i,(k+x)])
       if (k==(j+1)) {
         SFS_entry <- baselength[j,1]+(j_pop*k_pop)
       } else {
         extra_bit <- 0
         for (m in 1:(k-1)) {
           extra_bit <- extra_bit+(max_count[j]*max_count[m])
         }
         SFS_entry <- baselength[j,1]+(j_pop*k_pop)+extra_bit
       }
     SFS_original[SFS_entry] <- SFS_original[SFS_entry]+1
   }
  }
}      
      
        
        
  
