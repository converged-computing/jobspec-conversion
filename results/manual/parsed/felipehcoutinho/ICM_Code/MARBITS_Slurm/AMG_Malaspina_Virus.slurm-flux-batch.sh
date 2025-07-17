#!/bin/bash
#FLUX: --job-name=AMG_Hunter_Malaspina_Virus
#FLUX: -c=48
#FLUX: -t=259200
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/scratch/fcoutinho/Malaspina_Virus/Malaspina_CoAssembly_Viral_Scaffolds_Renamed.faa --info_cds_output CDS_Info_Malaspina_CoAssembly_Viral_Scaffolds_Renamed.tsv --info_genome_output Genome_Info_Malaspina_CoAssembly_Viral_Scaffolds_Renamed.tsv
