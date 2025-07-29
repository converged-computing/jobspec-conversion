#!/bin/bash
#FLUX: --job-name=ANNz_Regression
#FLUX: -t=129600
#FLUX: --urgency=16

source /fred/oz237/kluken/redshift_pipeline_adacs/Slurm/hpc_profile_setup.sh
mkdir seed_${SLURM_ARRAY_TASK_ID}
cd seed_${SLURM_ARRAY_TASK_ID}
singularity run $container_path/annz_latest.sif $script_path/annz.py -s ${SLURM_ARRAY_TASK_ID}  -l
