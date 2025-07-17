#!/bin/bash
#FLUX: --job-name=1
#FLUX: -n=50
#FLUX: --urgency=16

samples=
for i in samples
do
	whamg -f $i.recal.bam \
	-a reference.fas -x 50 \
	-c chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chrX,chrY \
	> $i.vcf
done
for i in samples
do
	svtyper \
	-i $i.vcf \
	-B $i.recal.bam \
	-o $i.geno.vcf \
	-T reference.fa
done
