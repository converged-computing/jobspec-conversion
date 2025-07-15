#!/bin/bash
#FLUX: --job-name=lovable-platanos-0199
#FLUX: --urgency=16

cd run_files.syncTM
module load matlab
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
