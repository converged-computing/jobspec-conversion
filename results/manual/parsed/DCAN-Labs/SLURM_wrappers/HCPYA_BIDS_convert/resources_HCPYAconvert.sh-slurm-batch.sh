#!/bin/bash
#FLUX: --job-name=DEAPderiv
#FLUX: --queue=amdsmall,small
#FLUX: -t=1800
#FLUX: --urgency=16

cd run_files.DEAPderiv
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
