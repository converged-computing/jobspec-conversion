#!/bin/bash
#FLUX: --job-name=itrust-linear_svc
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

source ../.experiments_env/bin/activate
srun python linear_svc.py ${SLURM_ARRAY_TASK_ID} context_ONLY-ACTION-SPREAD20_K3_H4_P12
