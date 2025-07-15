#!/bin/bash
#FLUX: --job-name=angry-bike-2064
#FLUX: --priority=16

cd run_files.QSIprep
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
