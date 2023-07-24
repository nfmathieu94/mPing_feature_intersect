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

An issue is occuring when trying to intersect the cleaned_RIL1to8_mPing.tsv file with the sorted_master_gff.tsv
An issue is occuring when trying to intersect the cleaned_RIL1to8_mPing.tsv file with the cleaned_gff.tsv
The issue does not occur when intersecting the cleaned_RIL1to8_mPing.tsv and the cleaned_intergenic.tsv file
The issue does not occur when intersecting the cleaned_RIL1to8_mPing.tsv and the with_introns.gff3
An issue is occuring when trying to intersect the cleaned_RIL1to8_mPing.tsv file with the sorted_master_gff.tsv

The issues above suggest that that the core issue is occuring when creating the clead_gff.tsv from the with_introns.gff3
This core issue is thus causing other issues when trying to intersect the downstream files (master_gff and sorted_master)
with the cleaned_RIL1to8_mPing.tsv


Feature Barplot (intersection_barplot.R):

The code below was used to get the mPing counts for each feature
cut -f3,3 withintrons_mPing_intersect.tsv | sort | uniq -c > gff_intersect_counts.tsvi

the intergenic mPing intersection file was also used as input for the bar plot. The number of rows was used for the mPing count
