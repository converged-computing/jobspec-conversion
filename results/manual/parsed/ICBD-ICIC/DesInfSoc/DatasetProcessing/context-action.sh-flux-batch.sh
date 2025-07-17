#!/bin/bash
#FLUX: --job-name=itrust-context
#FLUX: -t=172800
#FLUX: --urgency=16

source .context_env/bin/activate
srun python context-action.py ${SLURM_ARRAY_TASK_ID}
