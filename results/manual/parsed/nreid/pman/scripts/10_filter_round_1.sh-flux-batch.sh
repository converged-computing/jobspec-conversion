#!/bin/bash
#FLUX: --job-name=filter_vcfs
#FLUX: --queue=general
#FLUX: --urgency=16

hostname
date
module load bcftools/1.9
module load htslib/1.9
module load vcftools/0.1.16
module load vcflib/1.0.0-rc1
STACKS=../results/stacks
mkdir -p $OUTDIR
FB=../results/freebayes
mkdir -p $OUTDIR
vcftools --gzvcf $STACKS/populations.snps.dict.vcf.gz \
	--max-missing-count 10 --mac 3 --remove-indels --max-alleles 2 --min-alleles 2 \
	--recode \
	--stdout | \
	bgzip >$STACKS/filtered.vcf.gz
	# output missing individual report
	vcftools --gzvcf $STACKS/filtered.vcf.gz --out $STACKS/filtered --missing-indv
	# index
	tabix -p vcf $STACKS/filtered.vcf.gz
GEN=../genome/GCA_003704035.3_HU_Pman_2.1.3_genomic.fna
bcftools norm -f $GEN $FB/freebayes.vcf.gz | \
	vcfallelicprimitives --keep-info --keep-geno | \
	vcfstreamsort | \
	vcftools --vcf - \
	--max-missing-count 10 --mac 3 --remove-indels --max-alleles 2 --min-alleles 2 --minQ 30 \
	--recode \
	--stdout | bgzip >$FB/fb_filtered.vcf.gz
	# output missing individual report
	vcftools --gzvcf $FB/fb_filtered.vcf.gz --out $FB/fb_filtered --missing-indv
	# index
	tabix -p vcf $FB/fb_filtered.vcf.gz
