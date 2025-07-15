#!/bin/bash
#FLUX: --job-name=doopy-poo-1691
#FLUX: --priority=16

pipe="ATACseq"
cwd=$1
fastqDir=$2
sampleText=$3
genomeRef=$4
blacklist=$5
TSS=$6
mapq=$7
chromSize=$8
singleend=$9
exeDir=${10}
snakemake=${11}
echo `which python`
SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p $sampleText)
echo $SAMPLE
snakemake --snakefile $exeDir/Snakefile --nolock --use-conda --conda-prefix /rugpfs/fs0/risc_lab/scratch/risc_soft/miniconda3/envs/macs2_python2 --rerun-incomplete --cores 4 $snakemake --config "pipe='$pipe'" "fastqDir='$fastqDir'" "genomeRef='$genomeRef'" "blacklist='$blacklist'" "TSS='$TSS'" "mapq='$mapq'" "chromSize='$chromSize'" "sample='$SAMPLE'" "singleend='$singleend'"
