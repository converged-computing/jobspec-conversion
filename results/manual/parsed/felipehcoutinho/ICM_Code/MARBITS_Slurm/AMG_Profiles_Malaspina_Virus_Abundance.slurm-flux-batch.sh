#!/bin/bash
#FLUX: --job-name=AMG_Abundance_Profiles_Malaspina_Virus
#FLUX: -t=86400
#FLUX: --priority=16

module load python/3.8.5
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --parse_only True --abundance /mnt/lustre/scratch/elopez/5_bowtie_results/After_checkV_output/RPKM.tsv --cds /mnt/lustre/scratch/fcoutinho/Profiles_Malaspina/Assemblies_Round2/Viruses/Profiles_Malaspina_Viruses_CheckV_Trimmed_Genomes.faa
