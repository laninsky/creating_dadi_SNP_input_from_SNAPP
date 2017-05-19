# I use this code to figure out whether my bootstrap replicates need to have a different number of sites generated in order to more
# closely hew to the observed SFS in terms of non-monomorphic sites. For smaller SFS you can do this "by hand" (in excel), but if you 
# have multiple populations and a denser dataset, excel will choke and not be able to open the SFS

# Define your SFS path/file name
SFS_file <- "no_mig_MSFS.obs"

SFS <- readLines(SFS_file)
SFS_vector <- unlist(strsplit(SFS[3],"\\s+"))

total_SNP_no <- sum(as.numeric(SFS_vector))
non_monomorphic_SNPs <- sum(as.numeric(SFS_vector[-1]))



