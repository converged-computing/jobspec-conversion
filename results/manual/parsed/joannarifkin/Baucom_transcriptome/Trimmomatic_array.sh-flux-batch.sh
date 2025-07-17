#!/bin/bash
#FLUX: --job-name=Trimmomatic_Rifkin
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module load Bioinformatics
module load Bioinformatics  gcc/10.3.0-k2osx5y
module load trimmomatic
module list
mkdir -p ./Trimmomatic/
file=$(ls *.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo $file
TrimmomaticSE -threads 8 $file /Trimmomatic/trimmed_$file ILLUMINACLIP:TruSeq2-SE:2:30:10 LEADING:3 TRAILING:3 MAXINFO:50:0.5 MINLEN:36 
