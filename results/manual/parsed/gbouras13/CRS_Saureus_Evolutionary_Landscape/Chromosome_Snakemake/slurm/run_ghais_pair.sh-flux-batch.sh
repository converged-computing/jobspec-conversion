#!/bin/bash
#FLUX: --job-name=ghais_pair
#FLUX: -t=43200
#FLUX: --urgency=16

PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd ..
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 32 -s runner_ghais.smk --use-conda  --conda-frontend conda  \
--config csv=ghais_metadata.csv Output=../Paper_1_Snakemake_Output 
conda deactivate
