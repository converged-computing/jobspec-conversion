#!/bin/bash
#FLUX: --job-name=AMG_Hunter_Alteromonas_Transcriptome
#FLUX: -c=48
#FLUX: -t=86400
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/bio/shared/acinasLab/merclub/iss312-assembly-and-annotation/output/best-assembly-annotation/prokka/iss312.faa
