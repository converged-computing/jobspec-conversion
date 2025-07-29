#!/bin/bash
#FLUX: --job-name=StG23_AMG_Hunter_Virus
#FLUX: -c=24
#FLUX: -t=1296000
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
cd /mnt/lustre/scratch/fcoutinho/StG_23/Viruses/Annotation/Less_Threads/
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 23 --cds /mnt/lustre/scratch/fcoutinho/StG_23/Viruses/Annotation/IMGVR_Scaffolds_Comp_75-100_Max_Conta_0_vOTU_Representatives.faa
