#!/bin/bash
#FLUX: --job-name=AMG_Hunter_AD
#FLUX: -c=48
#FLUX: -t=172800
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/scratch/fcoutinho/Anaerobic_Digester/AD_Viruses_CDS.faa
