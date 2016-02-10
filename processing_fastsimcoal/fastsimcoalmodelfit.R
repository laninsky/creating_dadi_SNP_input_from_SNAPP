#You'll need to change the way the number of parameters in your data are calculated (line 34 onwards) as this will be specific to your dataset

#example inputs
#working_dir <- "C:/Users/a499a400/Dropbox/ceyx/dadi/runs/"
#dadi_spectrum <- "spectrum_output.txt"
#fastsimcoal_def_file <- "scenario.def"
#fastsimcoal_MSFS_file <- "scenario_MSFS.obs"
#no_sims <- 5
# e.g., call function by fastsimcoalmodelfit("C:/Users/a499a400/Dropbox/ceyx/dadi/runs/", "spectrum_output.txt", "scenario.def", "scenario_MSFS.obs", 5)

fastsimcoalmodelfit <- function(working_dir,dadi_spectrum,fastsimcoal_def_file,fastsimcoal_MSFS_file,no_sims) {

library(stringr)

setwd(working_dir)

spectrum <- readLines(dadi_spectrum)
spectrum <- unlist(strsplit(spectrum[2]," "))
number_of_cats <- length(spectrum)
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

toadd <- matrix(ncol=16,nrow=(no_scenarios+1))
toadd[1,] <- c("params",Rs,AdjsRs,RMSE)

output <- cbind(output,toadd)

for (i in 2:(no_scenarios+1)) {
x <- 0
if(!(output[i,6]==0)) {
x <- 1
}
if(!(output[i,7]==1)) {
x <- x + 1
}
output[i,beginning_output] <- 7 + x
}

output_no1st <- output
input <- readLines(fastsimcoal_MSFS_file)

x <- 1
i <- 1
while (i < length(input)) {
if (grepl("observations",input[i],fixed=TRUE)) {
x <- x + 1
for (j in 1:no_sims) {
temp <- unlist(strsplit(input[i+j+1],"\t"))
fit <- lm(as.numeric(spectrum) ~ as.numeric(temp))
output[x, beginning_output+j] <- summary(fit)$r.squared
output[x, (beginning_output+j+no_sims)] <- 1- (((1-summary(fit)$r.squared)*(number_of_cats-1))/(number_of_cats-as.numeric(output[x,beginning_output])-1))
output[x, (beginning_output+j+(2*no_sims))] <- mean((fit$residuals)^2)
}
}
i <- i + 1
}

write.table(output,"summarize_fastsimcoal.txt", sep="\t",quote=FALSE, row.names=FALSE,col.names=FALSE)

x <- 1
i <- 1
while (i < length(input)) {
if (grepl("observations",input[i],fixed=TRUE)) {
x <- x + 1
for (j in 1:no_sims) {
temp <- unlist(strsplit(input[i+j+1],"\t"))
fit <- lm(as.numeric(spectrum[-1]) ~ as.numeric(temp[-1]))
output_no1st[x, beginning_output+j] <- summary(fit)$r.squared
output_no1st[x, (beginning_output+j+no_sims)] <- 1- (((1-summary(fit)$r.squared)*(number_of_cats-1))/(number_of_cats-as.numeric(output_no1st[x,beginning_output])-1))
output_no1st[x, (beginning_output+j+(2*no_sims))] <- mean((fit$residuals)^2)
}
}
i <- i + 1
}

write.table(output,"summarize_fastsimcoal_no_monomorphic.txt", sep="\t",quote=FALSE, row.names=FALSE,col.names=FALSE)


}


