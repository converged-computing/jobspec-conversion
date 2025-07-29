#!/bin/bash
#SBATCH --output=FastQC.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=01:00:00
#SBATCH --chdir=/bigdata/jialab/rli012/PCa/data/fromSRA/GSE54460/

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
