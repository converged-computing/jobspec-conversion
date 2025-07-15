#!/bin/bash
#FLUX: --job-name=SAGs_CDS_AMG_Hunter
#FLUX: -c=48
#FLUX: -t=172800
#FLUX: --priority=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/scratch/fcoutinho/xlopez/98NCLDVproteins.faa --info_cds_output CDS_Info_98NCLDV.tsv --info_genome_output Genome_Info_98NCLDV.tsv
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 48 --cds /mnt/lustre/scratch/fcoutinho/xlopez/152viroph_proteins.faa --info_cds_output CDS_Info_152viroph.tsv --info_genome_output Genome_Info_152viroph.tsv
