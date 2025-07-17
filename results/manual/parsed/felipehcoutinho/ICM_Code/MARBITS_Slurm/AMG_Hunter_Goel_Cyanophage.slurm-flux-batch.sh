#!/bin/bash
#FLUX: --job-name=AMG_Hunter_Goel_Cyanophages
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 24 --cds /mnt/lustre/scratch/fcoutinho/Anaerobic_Digester/UL_Cyanophage_AMG.faa --info_cds_output CDS_Info_UL_Cyanophage_AMG.tsv --info_genome_output Genome_Info_UL_Cyanophage_AMG.tsv
