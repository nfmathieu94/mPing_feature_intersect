# Feature Intersect
--------------------
## Purpose
    The Feature Intersect part of this project is aimed to look at where mPing elements are
    landing in terms of genomic features. By using the RelocaTE2 results that determine the 
    genomic coordiantes of mPing, we can intersect this data frame with an annotation file
    to determine the frequency of mPing insertions in specific genomic features. 

## Details
* RelocaTE2 was ran on Illumina fastq files for 8 different RILs by JS
* One data frame was created to combine the different RIL results
* The data frame was simplified so that only the RIL number, chromosome
number, start site, and end site for each insertion is kept
* A gff3 file was downloaded that has genomic annotation for rice.

## Data
* The file was downloaded from the website is found [here](http://rice.uga.edu/home_overview.shtml)
* The specific download link used is [here]( http://rice.uga.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir/all.gff3)
* Data was downloaded 27-Jun-23
