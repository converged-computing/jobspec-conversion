#!/bin/bash
#FLUX: --job-name=faux-car-1073
#FLUX: --urgency=16

cd run_files.fMRI
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
