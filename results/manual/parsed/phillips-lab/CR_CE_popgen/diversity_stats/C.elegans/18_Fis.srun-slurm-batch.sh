#!/bin/bash
#FLUX: --job-name=fisCE
#FLUX: --queue=phillips
#FLUX: -t=54000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
cd /projects/phillipslab/ateterina/CE_haw_subset/data/BAMS/
VCFI="CE_population_filt_snps_5-100_0.5_fin.vcf"
ref="/projects/phillipslab/ateterina/CE_haw_subset/ref_245/c_elegans.PRJNA13758.WS245.genomic.fa"
VCF=${VCFI/vcf/MAF.vcf}
vcftools --vcf $VCFI --maf 0.05 --stdout --recode --recode-INFO-all  > $VCF
module load samtools easybuild  GCC/4.9.3-2.25  OpenMPI/1.10.2 HTSlib/1.6
module load bedtools plink
bgzip -c $VCF > $VCF.gz
tabix -p vcf $VCF.gz
mkdir -p FIS
cd FIS
bedtools makewindows -g $ref.fai -w 100000 > CE.windows.100kb.bed
rm -f CE_WILD_FIS_MAF_100.txt
while read window; do
	echo $window > TARGET.bed
	sed -i "s/ /:/" TARGET.bed
	sed -i "s/ /-/" TARGET.bed
	popStats --type PL --target 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27 --file ../$VCF.gz  --region $(cat TARGET.bed) > TMP.FIS
	awk '{ sum += $9 } END { if (NR > 0) print sum / NR }' TMP.FIS >TMP.FIS.SUM
	echo $window > WINDOW.bed
	sed -i "s/ /\t/g" WINDOW.bed
	paste -d'\t' WINDOW.bed TMP.FIS.SUM >>CE_WILD_FIS_MAF_100.txt
done < CE.windows.100kb.bed
