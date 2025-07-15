#!/bin/bash
#FLUX: --job-name=AMG_Hunter_BOV
#FLUX: -c=48
#FLUX: -t=10800
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --parse_only True --genome_abundance /mnt/lustre/scratch/fcoutinho/BOV/Corrected_Abundance/Clean_Names_Correct_RPKM_Abundance_Renamed_BOV_CheckV_Trimmed.tsv --cds /mnt/lustre/scratch/fcoutinho/BOV/Renamed_BOV_CheckV_Trimmed.faa
