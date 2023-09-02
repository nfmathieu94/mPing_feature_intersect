# adding column specifying that the regions are intergenic

# reading in a the intergenic table
intergenic <- read.table("../data/annotation/intergenic_regions.tsv")

# adding column with feature information and removing column names
intergenic$V4 <- "intergenic"
names(intergenic) <- NULL

write.table(intergenic,"../data/cleaned_intergenic.tsv", sep="\t", row.names=FALSE, quote=FALSE) 


