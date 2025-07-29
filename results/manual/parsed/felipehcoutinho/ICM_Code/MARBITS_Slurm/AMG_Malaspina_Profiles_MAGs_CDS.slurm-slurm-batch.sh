#!/bin/bash
#FLUX: --job-name=Malaspina_Profiles_CDS_AMG_Hunter
#FLUX: -t=86400
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
file=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --parse_only True --threads 12 --cds $file --info_cds_output CDS_Info_$file.tsv --info_genome_output Genome_Info_$file.tsv
