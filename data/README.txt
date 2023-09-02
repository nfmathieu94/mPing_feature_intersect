Obtaining Intergenic Regions and Introns from gff3 file:

'GCF_001433935.1_IRGSP-1.0_genomic.fna' was copied from /bigdata/wesslerlab/shared/Rice/RILs_2021/analysis/genome
'GCF_001433935.1_IRGSP-1.0_genomic.gff' was copied from /bigdata/wesslerlab/shared/Rice/RILs_2021/analysis/genome



Chromosome sizes were obtained by using:

module load samtools
samtools faidx GCF_001433935.1_IRGSP-1.0_genomic.fna
cut -f1,2 GCF_001433935.1_IRGSP-1.0_genomic.fna.fai > chromSizes.txt


chromSizes_no_contigs.txt was generated from the original chromSizes.txt by just grabbing the 12 chromosomes 
grep -e "NC_02925*" chromSizes.txt > chromSizes_no_contigs.txt


BED file was generated using awk: 
awk 'OFS="\t" {print $1, "0", $2}' chromSizes_no_contigs | sort -k1,1 -k2,2n > chromSizes.bed

GFF3 File was then sorted using:
cat GCF_001433935.1_IRGSP-1.0_genomic.gff | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k4,4n -k5,5n"}' > all_sorted.gff3


introns were added to the gff3 file using genometools:
- First the all.gff3 file needs phase corrections.This is done using "tidy" option. Once corrected,
The new cleaned up file can be used to add introns.

module load genometools
gt gff3 -tidy GCF_001433935.1_IRGSP-1.0_genomic.gff > all.clean.gff
gt gff3 -addintrons all.clean.gff > with_introns.gff


intergenic regions were obtained using bedtools:
- first the gff file needs to be sorted, and this is done using "sort" option. Once sorted,
the new file can be used to obtain intergenic regions

bedtools sort 
bedtools complement -i all_sorted.gff3 -g chromSizes.txt > complement.gff3

! Currently running into issues with the above step. I believe the issue has to do with the sorting. 
Data that I get back is for only Chr1, Chr10, Chr11, and Chr12. 
Error: Sorted input specified, but the file all_sorted.gff3 has the following record with a different sort order than the genomeFile chromSizes.txt
Chr2    MSU_osa1r7      three_prime_UTR 3514    3863    .       -       .       ID=LOC_Os02g01010.1:utr_1;Parent=LOC_Os02g01010.1

Fixed the issue by sorting both the gff3 file and the genome file the same way:

sort -k1,1 -k4,4n GCF_001433935.1_IRGSP-1.0_genomic.gff > sorted.gff
cut -f1 sorted.gff  uniq > chromosome_names.txt
grep -Fwf chromosome_names.txt chromSizes.txt | sort -k1,1 > sorted_chrom.txt


Whole chromosome windows need to be removed so that there are missing windows for bedtools complement:
grep -Pv "\tregion\t" sorted.gff > sorted_no_chrom_window.gff



Then created a file with intergenic regions using:

bedtools complement -i sorted_no_chrom_window.gff -g sorted_chrom.txt > intergenic_regons.txti

The 12 chromosomes were grabbed out of the intergenic_regions.txt file (intergenic windows from other contigs are removed):
grep -e "NC_0292[56][1-9].1" intergenic_regions.txt > intergenic_regions_12.txt


