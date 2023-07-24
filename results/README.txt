Currently running into issues combining the with_introns.gff with the cleaned_intergenic.gff

As of 7.19.23 the results in this directory were created using:

bedtools intersect -a cleaned_intergenic.tsv -b cleaned_RIL1to8_mPing.tsv > withintrons_mPing_intersect.tsv
bedtools intersect -a intergenic_regions.tsv -b cleaned_RIL1to8_mPing.tsv > intergenic_mPing_intersect.tsv

These temporary results will be used to create a bar plot.
At some point I need to go back and create the master gff that will be used to obtain the results and bar plot.
