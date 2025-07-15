#!/bin/bash
#FLUX: --job-name=persnickety-platanos-0527
#FLUX: --priority=16

cd run_files.fMRI
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
