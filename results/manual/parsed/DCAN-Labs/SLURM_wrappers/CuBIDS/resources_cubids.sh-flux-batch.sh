#!/bin/bash
#FLUX: --job-name=expressive-lettuce-6932
#FLUX: --priority=16

cd run_files.cubids
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
