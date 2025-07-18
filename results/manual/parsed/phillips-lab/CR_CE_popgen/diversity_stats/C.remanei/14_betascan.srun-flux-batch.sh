#!/bin/bash
#FLUX: --job-name=betascan
#FLUX: --queue=phillips
#FLUX: -t=126000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bedtools
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/EXONS_INTRONS
mkdir -p BETA
cd BETA
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
reffai="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta.fai"
INDEX="5-100_0.5"
VCF="/projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/CR_WILD_population14_filt_snps_${INDEX}_fin.vcf"
MASK="/projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/CR_mask_these_region_${INDEX}_WILD14.bed"
BED="/projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/CRPX506.windows.100kb.bed"
glactools="/projects/phillipslab/ateterina/scripts/glactools/glactools"
betascan="/projects/phillipslab/ateterina/scripts/BetaScan/BetaScan.py"
bedtools makewindows -g ${ref}.fai -w 100000 > ref.windows.100kb.bed
if [ ! -f headerBETA14.txt ]
then
	        grep "#" $VCF > headerBETA14.txtt
		fi
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
cat headerBETA14.txt > CR_WILD_genotypes.GT.FORMAT_${INDEX}.vcf
for chr in I II III IV V X;do
zcat ${VCF/.vcf/.noimpi2}.${chr}.vcf.gz|grep -v "#" -  >>CR_WILD_genotypes.GT.FORMAT_${INDEX}.vcf;
done
rm -f CR_${INDEX}.TMP*
rm CR_${INDEX}.100kb.BETA
while read window; do
        echo $window > CR_${INDEX}.TMP.TARGET.bed;
        sed -i "s/ /\t/g" CR_${INDEX}.TMP.TARGET.bed;
        cat headerBETA14.txt > CR_${INDEX}.TMP.vcf;
       bedtools intersect -b CR_${INDEX}.TMP.TARGET.bed -a CR_WILD_genotypes.GT.FORMAT_${INDEX}.vcf >> CR_${INDEX}.TMP.vcf
        $glactools vcfm2acf --onlyGT --fai $reffai CR_${INDEX}.TMP.vcf > CR_${INDEX}.TMP.acf.gz
        $glactools acf2betascan --fold CR_${INDEX}.TMP.acf.gz | gzip > CR_${INDEX}.TMP.beta.txt.gz
        python2 $betascan -i CR_${INDEX}.TMP.beta.txt.gz -fold -o CR_${INDEX}.TMP.betascores.txt
        #remove first line
        sed -i '1d' CR_${INDEX}.TMP.betascores.txt
        #average values
        awk  '{ sum += $2 } END { if (NR > 0) {print sum / NR ;} else {print "0"}}' CR_${INDEX}.TMP.betascores.txt > CR_${INDEX}.TMP.betascores.SUM.txt
paste -d'\t' CR_${INDEX}.TMP.TARGET.bed CR_${INDEX}.TMP.betascores.SUM.txt  >>CR_${INDEX}.100kb.BETA
done < $BED
rm -f CR_${INDEX}.TMP*
