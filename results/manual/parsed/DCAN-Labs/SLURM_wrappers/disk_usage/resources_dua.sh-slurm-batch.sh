#!/bin/bash
#FLUX: --job-name=ABCDdua
#FLUX: --queue=small,amdsmall,amd512,ram256g
#FLUX: -t=1800
#FLUX: --urgency=16

cd run_files.dua
module load singularity
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
