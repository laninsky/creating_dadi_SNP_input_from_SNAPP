#fastsimcoalmodelfit <- function(working_dir,dadi_spectrum,fastsimcoal_def_file,fastsimcoal_MSFS_file,no_sims) {

working_dir <- "C:/Users/Alana/Dropbox/ceyx/dadi/runs"
dadi_spectrum <- "spectrum_output.txt"
fastsimcoal_def_file <- "scenario.def"
fastsimcoal_MSFS_file <- "scenario_MSFS.obs"
no_sims <- 5

library(stringr)

setwd(working_dir)

spectrum <- readLines(dadi_spectrum)
spectrum <- unlist(strsplit(spectrum[2]," "))

output <- as.matrix(read.table(fastsimcoal_def_file))

no_scenarios <- dim(output)[1]-1
firstcol <- c("scenario",seq(1,no_scenarios,1))
output <- cbind(firstcol,output)
beginning_output <- dim(output)[2] + 1

Rs <- NULL
AdjsRs <- NULL
RMSE <- NULL

for (i in 1:no_sims) {
Rs <- cbind(Rs, paste("R_",i,sep=""))
AdjsRs <- cbind(AdjsRs, paste("AdjR_",i,sep=""))
RMSE <- cbind(RMSE, paste("RMSE_",i,sep=""))
}

toadd <- matrix(ncol=15,nrow=(no_scenarios+1))
toadd[1,] <- c(Rs,AdjsRs,RMSE)

output <- cbind(output,toadd)




