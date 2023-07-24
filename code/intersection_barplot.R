library(ggplot2)
library(wesanderson)


# Reading in the gff intersect file. In the future this will be replaced with the master gff
gff_inter_df <- read.table("../results/gff_intersect_counts.tsv", col.names= c("counts", "feature"))
intergenic_df <- read.table("../results/intergenic_mPing_intersect.tsv")

# Using the number of rows to obtain mPing insertion counts
intergenic_num <- nrow(intergenic_df)

# Adding the total intergenic counts to the list with other features
gff_inter_df[nrow(gff_inter_df) + 1,] <- list(intergenic_num, "intergenic")


p <- ggplot(data=gff_inter_df, aes(x=feature, y=counts, fill=feature)) +
    geom_bar(stat="identity")+
    scale_fill_manual(values=wes_palette(n=8, name="GrandBudapest1", type="continuous"))+
    theme(legend.position = "none")

ggsave(p, file="../results/feature_barplot.png", width=10, height=7)
