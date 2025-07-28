#!/bin/bash
#FLUX: --job-name=run_pileup_founders
#FLUX: --queue=compute
#FLUX: -t=115200
#FLUX: --urgency=16

module load singularity
REPO_BASE=$(pwd)
BAM=supporting_files/toy_10X/toy_reads.final.bam
VCF=$REPO_BASE/variants/CC_founders_v4.snps.vcf.gz
BC=supporting_files/toy_10X/toy_barcode.txt
OUTDIR=$REPO_BASE/demuxlet_results/toy
singularity run $REPO_BASE/containers/popscle-1.0.sif dsc-pileup \
    --sam $BAM --vcf <(zcat $VCF) --out $OUTDIR \
    --sam-verbose 10000000 --vcf-verbose 250000 \
    --tag-group CB --tag-UMI UB --group-list $BC
