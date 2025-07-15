#!/bin/bash
#FLUX: --job-name=AMG_Hunter_TOPC_Virus
#FLUX: -c=48
#FLUX: -t=259200
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/scratch/fcoutinho/TARA_Polar/Renamed_Viruses_Genomes_Filtered_All_Tara_Polar_Coassemblies_Contigs.faa --info_cds_output CDS_Info_Renamed_Viruses_Genomes_Filtered_All_Tara_Polar_Coassemblies_Contigs.tsv --info_genome_output Genome_Info_Renamed_Viruses_Genomes_Filtered_All_Tara_Polar_Coassemblies_Contigs.tsv
