#!/bin/bash
#FLUX: --job-name=exon-intron
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load racs-eb snpEff/3.6-Java-1.7.0_80
module load bedtools
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
snpEff="/projects/eb-racs/p/software/snpEff/3.6-Java-1.7.0_80/snpEff.jar"
gff="c_elegans.PRJNA13758.WS245.annotations.gff3"
ref="/projects/phillipslab/ateterina/CE_haw_subset/ref_245/c_elegans.PRJNA13758.WS245.genomic.fa"
cd /projects/phillipslab/ateterina/CE_haw_subset/data/BAMS/EXONS_INTRONS/
grep "WormBase" $gff | grep -P "\texon\t" - > Exons.gff
grep "WormBase" $gff | grep -P "\tintron\t" - > Introns.gff
cat $ref.fai |grep -v "MtDNA" - | awk '{print $1"\t0\t"$2-1}' - >Genome.bed
bedtools makewindows -g $ref.fai -w 100000 > CE.windows.100kb.bed
awk '{print$1"\t"$4-1"\t"$5-1}' Introns.gff | grep -v "MtDNA" -> Introns_ok.bed
awk '{print$1"\t"$4-1"\t"$5-1}' Exons.gff |grep -v "MtDNA" -> Exons_ok.bed
bedtools subtract -a Introns_ok.bed -b ../CE_mask_these_region5-100_0.5.bed > Introns_fin.bed
bedtools subtract -a Exons_ok.bed -b ../CE_mask_these_region5-100_0.5.bed > Exons_fin.bed
vcftools --vcf ../CE_population_filt_snps_5-100_0.5_fin.vcf  --site-pi --bed Introns_fin.bed --out CE_introns
vcftools --vcf ../CE_population_filt_snps_5-100_0.5_fin.vcf  --site-pi --bed Exons_fin.bed --out CE_exons
bedtools coverage -b Introns_fin.bed -a CE.windows.100kb.bed > CE_Introns.COVERAGE_100Kb.bed
bedtools coverage -b Exons_fin.bed -a CE.windows.100kb.bed > CE_Exons.COVERAGE_100Kb.bed
awk '{print $1"\t"$2-1"\t"$2"\t"$3}' CE_exons.sites.pi >CE_exons.sites.pi.bed
awk '{print $1"\t"$2-1"\t"$2"\t"$3}' CE_introns.sites.pi >CE_introns.sites.pi.bed
sed -i '1d' CE_exons.sites.pi.bed
sed -i '1d' CE_introns.sites.pi.bed
bedtools map -b CE_exons.sites.pi.bed -a CE.windows.100kb.bed -c 4 -o sum > CE_exons_pi_100kb_FIN.bed
bedtools map -b CE_introns.sites.pi.bed -a CE.windows.100kb.bed -c 4 -o sum > CE_introns_pi_100kb_FIN.bed
