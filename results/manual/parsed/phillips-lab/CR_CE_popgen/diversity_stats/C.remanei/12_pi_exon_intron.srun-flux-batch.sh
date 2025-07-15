#!/bin/bash
#FLUX: --job-name=exon-intron
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bedtools
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/EXONS_INTRONS
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
gff="CR_annotation_fixed_gaps.gff"
grep  -v "CM021150.1" $gff | grep -P "\texon\t" - > Exons.gff
grep  -v "CM021150.1" $gff | grep -P "\tintron\t" - > Introns.gff
cat $ref.fai |grep -v "MtDNA" - | awk '{print $1"\t0\t"$2-1}' - >Genome.bed
bedtools makewindows -g $ref.fai -w 100000 > CR.windows.100kb.bed
awk '{print$1"\t"$4-1"\t"$5-1}' Introns.gff |grep -v "MtDNA" - > Introns_ok.bed
awk '{print$1"\t"$4-1"\t"$5-1}' Exons.gff |grep -v "MtDNA" - > Exons_ok.bed
bedtools subtract -a Introns_ok.bed -b ../CR_mask_these_region_5-100_0.5_WILD14.bed > Introns_fin.bed
bedtools subtract -a Exons_ok.bed -b ../CR_mask_these_region_5-100_0.5_WILD14.bed > Exons_fin.bed
vcftools --vcf ../CR_WILD_population14_filt_snps_5-100_0.5_fin.vcf  --site-pi --bed Introns_fin.bed --out CR_introns
vcftools --vcf ../CR_WILD_population14_filt_snps_5-100_0.5_fin.vcf  --site-pi --bed Exons_fin.bed --out CR_exons
bedtools coverage -b Introns_fin.bed -a CR.windows.100kb.bed > CR_Introns.COVERAGE_100Kb.bed
bedtools coverage -b Exons_fin.bed -a CR.windows.100kb.bed > CR_Exons.COVERAGE_100Kb.bed
awk '{print $1"\t"$2-1"\t"$2"\t"$3}' CR_exons.sites.pi >CR_exons.sites.pi.bed
awk '{print $1"\t"$2-1"\t"$2"\t"$3}' CR_introns.sites.pi >CR_introns.sites.pi.bed
sed -i '1d' CR_exons.sites.pi.bed
sed -i '1d' CR_introns.sites.pi.bed
bedtools map -b CR_exons.sites.pi.bed -a CR.windows.100kb.bed -c 4 -o sum > CR_exons_pi_100kb_FIN.bed
bedtools map -b CR_introns.sites.pi.bed -a CR.windows.100kb.bed -c 4 -o sum > CR_introns_pi_100kb_FIN.bed
