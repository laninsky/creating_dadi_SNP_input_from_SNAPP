#fastsimcoalmodelfit <- function(working_dir,dadi_spectrum,fastsimcoal_def_file,fastsimcoal_MSFS_file) {

working_dir <- "C:/Users/a499a400/Dropbox/ceyx/dadi/runs"
dadi_spectrum <- "spectrum_output.txt"
fastsimcoal_def_file <- "scenario.def"
fastsimcoal_MSFS_file <- "scenario_MSFS.obs"

library(stringr)

spectrum <- readLines(dadi_spectrum)
spectrum <- unlist(strsplit(spectrum[2]," "))

output <- as.matrix(read.table(fastsimcoal_def_file))

no_scenarios <- dim(output)[1]-1
firstcol <- c("scenario",seq(1,no_scenarios,1))
output <- cbind(firstcol,output)
