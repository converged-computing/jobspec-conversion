#!/bin/bash
#FLUX: --job-name=itrust-support_vector_machine
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

source ../.experiments_env/bin/activate
srun python support_vector_machine.py ${SLURM_ARRAY_TASK_ID} context_ONLY-ACTION_K3_H4_P12-BINARY
