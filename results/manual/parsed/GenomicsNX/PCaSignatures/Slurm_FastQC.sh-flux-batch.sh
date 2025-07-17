#!/bin/bash
#FLUX: --job-name=scruptious-underoos-6245
#FLUX: -n=4
#FLUX: --queue=intel
#FLUX: -t=3600
#FLUX: --urgency=16

fastqc=/bigdata/jialab/rli012/software/FastQC/fastqc
N=$SLURM_ARRAY_TASK_ID
CPU=$SLURM_NTASKS
FILE=`ls raw/SRR*\.fastq.gz | grep _1.fastq.gz | head -n $N | tail -n 1`
PREFIX=${FILE%_1.fastq.gz}
PREFIX=${PREFIX#raw/}
fq1=$FILE
fq2=${FILE/_1/_2}
echo 'Start QC...'
echo $PREFIX
$fastqc $fq1 --outdir=FastQC/
$fastqc $fq2 --outdir=FastQC/
echo 'Done!'
