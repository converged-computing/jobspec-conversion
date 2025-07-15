#!/bin/bash
#FLUX: --job-name=Runacc2Fasta
#FLUX: -t=14400
#FLUX: --priority=16

dirtemplate='/home/yc954/project.cohen/sm_Bioproj2Lineage/dirTemplate/'
bioproj='PRJNA736718'
batchno=23
alljson=$(echo '/home/yc954/project.cohen/sm_Bioproj2Lineage/'${bioproj}'/batch'${batchno}'/sm_Accs2Runaccs/json_summarise/js_summarise_dummy.tsv')
reference='/home/yc954/project.cohen/sm_Bioproj2Lineage/dirTemplate/reference/NC_000962_3.fa'
dirscript='/home/yc954/project.cohen/sm_Bioproj2Lineage/dirTemplate/scripts/'
nthreads=$SLURM_NTASKS_PER_NODE
basedir=$(pwd) 
myoutputname='fasta_summary_dummy.tsv'
mkdir -p sm_Runacc2Fasta
cd ./sm_Runacc2Fasta
cp -n ${dirtemplate}sm_Runacc2Fasta/Snakefile .
mkdir -p ./results #tb-profiler throws errors if this directory does not exist beforehand.
mkdir -p ./raw_reads #for rule get_fastq
module purge
module load miniconda/23.5.2
conda activate snakemake
module load BWA SAMtools
snakemake --cores all --config alljson=${alljson} reference=${reference} basedir=${basedir}/sm_Runacc2Fasta/ dirscript=${dirscript} myoutput=${myoutputname} nthreads=${nthreads}
