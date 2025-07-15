#!/bin/bash
#FLUX: --job-name=itrust-sentiments
#FLUX: -t=432000
#FLUX: --priority=16

source .sentiments_env/bin/activate
srun python metrics_pysentimiento.py ${SLURM_ARRAY_TASK_ID}
