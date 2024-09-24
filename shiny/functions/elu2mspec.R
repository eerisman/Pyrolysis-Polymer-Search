elu2mspec <- function(x){
  temp <- readLines(x)
  temp <- paste(temp, collapse = "") # collapse into one vector
  temp <- strsplit(gsub("(NAME)","~\\1",temp),"~")[[1]] # gsub("(NAME)","~\\1",test1) adds ~ to split on
  temp <- temp[-1] #remove heading blank line
  temp <- gsub("[A-Z]0.[0-9]","", temp) # delete uppercase0.number for "uncertain peaks"
  temp <- gsub("NAME: .*RI", "NAME: RI", temp) # delete between NAME: and RI
  temp <- gsub("\\|.*NUM PEAKS:", "NUM PEAKS:", temp) #delete between | and NUM PEAKS:
  temp <- gsub("NAME: ", "\\\n\nNAME:\\\n", temp) #new line for NAME:
  temp <- gsub("RI", "Retention_index: SemiStdNP=", temp) #new line for Retention index
  temp <- gsub("NUM PEAKS", "\\\nNUM PEAKS", temp)# new line for Num PEAKS
  temp <- sub("\\(", "\\\n(", temp) #new line for the mz/abund
  temp[1] <- sub("\\\n\\\n", "", temp[1]) #remove leading 2 blank lines
  for (i in 1:length(temp)) {temp[i] <- sub("NAME:", paste("NAME: Peak",i), temp[i])} #add name to the compounds
  y <- sub("ELU", "MSPEC", x)
  y <- gsub(".*\\/", "", y)
  cat(temp, file = paste0("./data/",y))
}