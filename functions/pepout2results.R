pepout2result <- function(x) {
  peaks <- read.csv(x, skip = 3, header = TRUE, sep = "\t") #read pepsearch output skipping first 3 lines
  peaks <- head(peaks,-2) #delete last 2 rows
  
  peaks2 <- data.frame(do.call('rbind', strsplit(peaks$Unknown, "RI="))) #split the compound #/RI
  colnames(peaks2) <- c("Compound", "cRI") #rename column into something useful
  
  peaks <- cbind(peaks2, peaks[,-1])  #combine 
  peaks <- as.data.frame(gsub("-S", "", as.matrix(peaks))) # remove "-S" from RI 
  peaks <- peaks[c("Compound", "cRI", "Rank", "Id", "MF", "Match.no.RI", "RI", "Name", "Formula", "CE", "CAS")]
  peaks[c("cRI", "MF", "Rank","RI", "Id")] <- as.numeric(as.matrix(peaks[c("cRI", "MF", "Rank", "RI","Id")])) #convert numbers to numeric
  
  #checking for duplicates where Rank == 1
  peaks.top <- peaks[peaks$Rank ==1,] 
  peaks.top <- peaks.top[order(peaks.top$MF, decreasing = TRUE),] 
  peaks.top <- peaks.top[!duplicated(peaks.top$Id),]  #removed duplicated Ids eg highest MF is taken as the ID if multiple peaks have same Id
  
  #checking for duplicates where Rank != 1
  peaks.nottop <- peaks[peaks$Rank !=1,]
  peaks.nottop <- peaks.nottop[order(peaks.nottop$MF, decreasing = TRUE),] 
  peaks.nottop <- peaks.nottop[!duplicated(peaks.nottop$Id),]
  
  #combining and checking for duplicate where Rank ==1 and rank != 1
  peaks.total <- rbind(peaks.top, peaks.nottop)
  peaks.total <- peaks.total[!((duplicated(peaks.total$Id) | duplicated(peaks.total$Id, fromLast = TRUE)) & peaks.total$Rank != 1),]
  peaks.total <- peaks.total[order(peaks.total$cRI),]
  
  #tabulating polymer peakss
  polymers <- as.data.frame(table(unlist(strsplit(peaks.total$CE, "; ")))) #separating when same compound found in multiple polymers
  polymers[,3] <- as.numeric(gsub('.*\\((.*)\\).*', '\\1', polymers[,1])) #how many peak in each polymer in library
  polymers[,4] <- polymers[,2]/polymers[,3]  #proportion of peaks found vs in library
  polymers <- polymers[order(polymers[,4], decreasing = TRUE),] #ordering the table
  polymers$Var1 <- as.character(gsub(" \\(.*\\)", "",polymers$Var1)) #making the polymer as usable for grep
  for (i in 1:length(polymers$Var1)){polymers[i,5] <-ave(peaks.total$MF[grep(polymers$Var1[i],peaks.total$CE)])[1]} #determining average MF of library peaks found for each polymer
  polymers[,6] <- polymers[,4] * polymers[,5] #creating final metric
  colnames(polymers) <- c("polymer", "found", "library", "ratio", "aveMF", "finalscore")
  for (i in 1:length(unique(peaks.total$Compound))) {peaks.total$Compound <- gsub(unique(peaks.total$Compound)[i], paste("Pyrolyzate",i), peaks.total$Compound)}
  colnames(peaks.total) <- sub("CE", "Polymer", colnames(peaks.total))
  write.csv(peaks.total, file = "./results/peaks.csv", row.names = FALSE)
  write.csv(polymers, file = "./results/polymers.csv", row.names = FALSE)
  result <- list("peaks" = peaks.total, "polymers" = polymers)
}