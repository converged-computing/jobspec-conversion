#!/bin/bash
#FLUX: --job-name=methylation
#FLUX: --queue=batch
#FLUX: -t=255600
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/S_Aureus_Methylation"
PROF_DIR="$SNK_DIR/snakemake_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 1 -s rebasecall_runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/methylation_gpu  \
--config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Methylation/Output 
snakemake -c 1 -s nanodisco_runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/methylation  \
--config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Methylation/Output 
conda deactivate
