# This code is used to remove the blank rows which are repeats in the sorted master gff file

master_df <- read.table("../data/sorted_master_gff.tsv", row.names=NULL, fill=TRUE)

names(master_df) <- NULL
head(master_df)

write.table(master_df, "../data/sorted_master_gff_test1.tsv", quote=FALSE, row.names=FALSE)
