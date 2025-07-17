#!/bin/bash
#FLUX: --job-name=PLACEHOLDER-trimmomatic-log
#FLUX: --queue=intel
#FLUX: -t=28800
#FLUX: --urgency=16

date
module load trimmomatic
cd $SLURM_SUBMIT_DIR
READ1=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/PLACEHOLDER_R1_001.fastq.gz
READ2=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/PLACEHOLDER_R2_001.fastq.gz
OUTPUT1=/rhome/danielaz/bigdata/transcriptomics/trim_fastq
trimmomatic PE ${READ1} ${READ2} \
 ${OUTPUT1}/PLACEHOLDER.forward.paired \
 ${OUTPUT2}/PLACEHOLDER.foward.unpaired \
 ${OUTPUT2}/PLACEHOLDER.reverse.paired \
 ${OUTPUT2}/PLACEHOLDER.reverse.unpaired \
 ILLUMINACLIP:TrueSeq3-PE.fa:2:30:10 \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
hostname
