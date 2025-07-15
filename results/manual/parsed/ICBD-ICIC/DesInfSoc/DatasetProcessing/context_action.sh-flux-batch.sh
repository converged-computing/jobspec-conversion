#!/bin/bash
#FLUX: --job-name=itrust-context
#FLUX: -t=86400
#FLUX: --urgency=16

source .context_env/bin/activate
srun python context_action.py ${SLURM_ARRAY_TASK_ID}
