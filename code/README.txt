Different R scripts were made to reformat the mPing insertion file, the intergenic regions, and the gff file
Column names were removed and the identifier column was fixed so that the chromosome numbering was the same 
between files. 

The resulting files from the R code are labeled with "clean" as the prefix

The cleaned gff file and the cleaned intergenic file were concatenated and saved as a new file

cat cleaned_intergenic.tsv cleaned_gff.tsv > master_gff.tsv

The master gff file was then sorted 

sort -k 1,1 -k2,2n master_gff.tsv > sorted_master_gff.tsv

The sorted master gff file and the mPing insertion file were then used for the bedtool intersection

When running the bedtools intersect on these two files I am running into a data formatting issue
I suspect this has to do with the blank values in the sorted master file.

module load bedtools
bedtools intersect -a cleaned_RIL1to8_mPing.tsv -b  sorted_master_gff.tsv > intersect_file.tsv

Fixed problem on 7.15.2023
- Fixed the issue by reading in the sorted_master_gff.tsv, removing row names and quotes
    - the code for this can be found in removing_master_blanks.R


