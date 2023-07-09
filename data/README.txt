Obtaining Intergenic Regions and Introns from gff3 file:

Chromosome sizes were obtained by using:

samtools faidx all.con
cut -f1,2 all.con.fai > chromSizes.txt

all.con was downloaded here http://rice.uga.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir/

chromSizes_12.txt was generated from the original chromSizes.txt by just grabbing the 12 chromosomes 

BED file was generated using awk: 
'OFS="\t" {print $1, "0", $2}' chromSizes.txt | sort -k1,1 -k2,2n > chromSizes.bed

GFF3 File was then sorted using:
cat all.gff3 | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k4,4n -k5,5n"}' > all_sorted.gff3


introns were added to the gff3 file using genometools:
- First the all.gff3 file needs phase corrections.This is done using "tidy" option. Once corrected,
The new cleaned up file can be used to add introns.

gt gff3 -tidy all.gff3 > all.clean.gff3
gt gff3 -addintrons all.clean.gff3 > with_introns.gff3


intergenic regions were obtained using bedtools:
- first the gff3 file needs to be sorted, and this is done using "sort" option. Once sorted,
the new file can be used to obtain intergenic regions

bedtools sort 
bedtools complement -i all_sorted.gff3 -g chromSizes.txt > complement.gff3

! Currently running into issues with the above step. I believe the issue has to do with the sorting. 
Data that I get back is for only Chr1, Chr10, Chr11, and Chr12. 
Error: Sorted input specified, but the file all_sorted.gff3 has the following record with a different sort order than the genomeFile chromSizes.txt
Chr2    MSU_osa1r7      three_prime_UTR 3514    3863    .       -       .       ID=LOC_Os02g01010.1:utr_1;Parent=LOC_Os02g01010.1

Fixed the issue by sorting both the gff3 file and the genome file the same way:

sort -k1,1 -k4,4n all.gff3 > sorted.gff3
cut -f1 sorted.gff3 | uniq > chromosome_names.txt
grep -Fwf chromosome_names.txt chromSizes.txt | sort -k1,1 > sorted_chrom.txt

Then created a file with intergenic regions using:

bedtools complement -i sorted.gff3 -g sorted_chrom.txt > intergenic_regions.txt


