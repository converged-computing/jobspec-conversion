#!/bin/bash
#FLUX: --job-name=frigid-staircase-2256
#FLUX: --urgency=16

genus_species=$1
module load bioinfo
module load bwa
module load samtools
module load picard-tools/2.9.0
module load GATK/3.8.1
module load bamtools
mkdir -p /scratch/bell/dewoody/theta/${genus_species}/sra/final_bams/
cd /scratch/bell/dewoody/theta/${genus_species}/*_ref/
PicardCommandLine CreateSequenceDictionary reference=ref.fa output=ref.dict
cd /scratch/bell/dewoody/theta/${genus_species}/sra/cleaned/
bwa index -a bwtsw ../../*_ref/ref.fa
ls -1 *.fq | sed "s/_[1-2]_val_[1-2].fq//g" | uniq > cleaned_sralist
