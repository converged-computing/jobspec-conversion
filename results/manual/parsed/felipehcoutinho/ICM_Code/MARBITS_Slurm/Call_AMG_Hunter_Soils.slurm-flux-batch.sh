#!/bin/bash
#FLUX: --job-name=AMG_Hunter_Soil
#FLUX: -c=24
#FLUX: -t=432000
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl/5.28
module load prodigal
cd /mnt/lustre/scratch/fcoutinho/Soil_Elena/
python3 /mnt/lustre/bio/users/fcoutinho/Repos/virathon/Virathon.py --threads 23 --genome_files /mnt/lustre/scratch/fcoutinho/Soil_Elena/Post_CheckV_Trimmed_True_Virus_Soil_Genomes.fasta --call_prodigal True
cd /mnt/lustre/scratch/fcoutinho/Soil_Elena/Annotation/
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 23 --cds /mnt/lustre/scratch/fcoutinho/Soil_Elena/Post_CheckV_Trimmed_True_Virus_Soil_Genomes.faa
