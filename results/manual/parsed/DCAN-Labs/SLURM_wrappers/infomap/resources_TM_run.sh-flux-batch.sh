#!/bin/bash
#FLUX: --job-name=chunky-lizard-0988
#FLUX: --priority=16

cd run_files.syncTM
module load matlab
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
