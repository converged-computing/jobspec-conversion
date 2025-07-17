#!/bin/bash
#FLUX: --job-name=whole
#FLUX: -c=2
#FLUX: --queue=amd512,amdsmall,amdlarge,ram256g
#FLUX: -t=43200
#FLUX: --urgency=16

cd run_files.syncTM
module load matlab
file=run${SLURM_ARRAY_TASK_ID}
bash ${file}
