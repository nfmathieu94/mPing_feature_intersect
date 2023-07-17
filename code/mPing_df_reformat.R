# Purpose of this code is to reformat RIL2_1-8 data frame
# Some of the reformatting includes separating chromosome and start location into separate columns
# and changing the accession names to specific chromosomes 

library(dplyr)



# read in data frame
old_df <- read.csv("../data/RIL2_1-8_mPing_data.csv")

head(old_df)
# separate RIL line from start position
df <-
  tidyr::separate(
    data = old_df,
    col = RIL_Start,
    sep = c(11),
    into = c("Chr", "Start"),
    remove = FALSE
  )

# Removing underscore from Start column
df$Start <- as.numeric(sub("^[^_]*_", "", df$Start))

# Removing original RIL_Start column
df <- df[,-1]

head(df)

# Creating data frames that will serve as key for replacing text in df above

# Making accession key
acc <- unique(df$Chr)
chr <- paste("Chr", 1:13, sep="_")
acc_key <- data.frame(acc, chr)

# Making RIL key 
file_name <- unique(df$file)
RIL_name <- paste("RIL", 1:8, sep="_")
RIL_key <- data.frame(file_name, RIL_name)


# Replacing Values in df using key value pairi
# First replacing accession numbers with chromosome number
replaced_acc <- df %>%
  mutate(Chr = if_else(!is.na(Chr), acc_key$chr[match(Chr, acc_key$acc)], Chr))
# Second adding a RIL column that uses the file_name to determine which RIL number to use
add_RIL <- replaced_acc %>%
  mutate(RIL = RIL_key$RIL_name[match(file, RIL_key$file_name)])

# Subsetting add_RIL to obtain final data frame that will be used for annotation comparison

new_df <- add_RIL[,c("RIL", "Chr", "Start", "end")]

# Moving first column to last
cleaned_df <- new_df %>%
    select(-RIL,RIL)

# Removing underscore from col1
cleaned_df$Chr <- sub("_", "", cleaned_df$Chr)

# removing col names 
names(cleaned_df) <- NULL

write.csv(cleaned_df, "../data/cleaned_RIL1to8_mPing.csv", row.names=FALSE, quote=FALSE)
write.table(cleaned_df, "../data/cleaned_RIL1to8_mPing.tsv", sep="\t", row.names=FALSE, quote=FALSE)

head(cleaned_df)
