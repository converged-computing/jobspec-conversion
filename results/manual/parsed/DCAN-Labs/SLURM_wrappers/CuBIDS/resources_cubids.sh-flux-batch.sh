#!/bin/bash
#FLUX: --job-name=cubids-validate
#FLUX: -t=1200
#FLUX: --urgency=16

cd run_files.cubids
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
