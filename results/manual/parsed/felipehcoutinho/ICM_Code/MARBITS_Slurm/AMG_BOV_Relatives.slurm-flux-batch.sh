#!/bin/bash
#FLUX: --job-name=AMG_Hunter_BOV_Relatives
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 24 --cds /mnt/lustre/scratch/fcoutinho/BOV/Manual_Curation/Relatives_Seq_898+587_Genomes.faa --info_cds_output CDS_Info_BOV_Relatives.tsv --info_genome_output Genome_Info_BOV_Relatives.tsv
