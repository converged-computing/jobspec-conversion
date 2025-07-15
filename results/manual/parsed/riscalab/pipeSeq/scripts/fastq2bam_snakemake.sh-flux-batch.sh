#!/bin/bash
#FLUX: --job-name=carnivorous-toaster-9774
#FLUX: --urgency=16

pipe="fastq2bam"
cwd=$1
fastqDir=$2
sampleText=$3
genomeRef=$4
blacklist=$5
mapq=$6
singleend=$7
exeDir=$8
snakemake=$9
echo This is job $SLURM_JOB_ID
echo `which python`
SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p $sampleText)
echo $SAMPLE
snakemake --snakefile $exeDir/Snakefile --nolock --rerun-incomplete --cores 4 $snakemake --config "pipe='$pipe'" "fastqDir='$fastqDir'" "genomeRef='$genomeRef'" "blacklist='$blacklist'" "mapq='$mapq'" "sample='$SAMPLE'" "singleend='$singleend'"
