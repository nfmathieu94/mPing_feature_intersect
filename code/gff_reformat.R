
# Read gff table in 
gff_df <- read.table("../data/with_introns.gff3")

# Rearrange column order

gff_df <- gff_df[ , c("V1", "V4", "V5", "V3")]

# Remove col nammes
names(gff_df) <- NULL

# Write table
write.table(cleaned_df, "../data/cleaned_RIL1to8_mPing.tsv", sep="\t", row.names=FALSE, quote=FALSE)   
