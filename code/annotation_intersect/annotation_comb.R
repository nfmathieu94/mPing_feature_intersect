# The following code is used to make a combined annotation file that will be used 
# for the bedtool intersection. The combined table will have the proper format that 
# can be used for intersecting with bed files 

gff <- read.table("../../data/Annotation/sub_gf.gff3", header=TRUE)
inter <- read.table("../../data/Annotation/intergenic_regions.txt")


