# Reading in gff file 

raw_gff <- read.table("../../data/Annotation/all.gff3")
head(raw_gff)

sub_gff <- raw_gff[, c("V1", "V3","V4", "V5", "V7")]
sub_gff

# Assigning different column names
colnames(sub_gff) <- c("Chr", "Feature", "Start", "end", "strand")
# Saving subset of gff as file
write.table(sub_gff, "../../data/Annotation/sub_gf.gff3", row.names=FALSE, quote=FALSE)

