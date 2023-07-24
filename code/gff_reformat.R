# Read gff table in 
gff_df <- read.table("../data/with_introns.gff3")
colnames(gff_df)
# Rearrange column order

gff_df <- gff_df[ , c("V1", "V4", "V5", "V3")]

# Remove col nammes
names(gff_df) <- NULL
head(gff_df)
# Write table
write.table(gff_df, "../data/cleaned_gff.tsv", sep="\t", row.names=FALSE, quote=FALSE)   
