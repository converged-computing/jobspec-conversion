#!/bin/bash
#FLUX: --job-name=ABCDdua
#FLUX: -t=1800
#FLUX: --priority=16

cd run_files.dua
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
