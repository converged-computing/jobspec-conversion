#!/bin/bash
#SBATCH --job-name=PLACEHOLDER-trimmomatic-log
#SBATCH --output=PLACEHOLDER.stdout
#SBATCH --mail-user=danielaz@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=08:00:00

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
