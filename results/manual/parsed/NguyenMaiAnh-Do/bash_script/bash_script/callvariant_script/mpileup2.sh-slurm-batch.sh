#!/bin/bash
#FLUX: --job-name=mpileup_call_2
#FLUX: -c=28
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate nextflow
bed=/home/ndo/GIAB-GT/HG001_GRCh38_1_22_v4.2.1_benchmark.bed
ref=/home/ndo/GIABv3Ref/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta
prior=0.99
bam=/home/ndo/03_final_bam/SRR13586007_sortCoord.bam
bcftools mpileup -Q1 --max-BQ 60 -I -a FORMAT/AD -Ou --threads 28 -T $bed -f $ref $bam \
| bcftools call --threads 10 -Oz -mv -P $prior -o /home/ndo/04_callvariant_vcf/SRR13586007_bcftools.vcf
