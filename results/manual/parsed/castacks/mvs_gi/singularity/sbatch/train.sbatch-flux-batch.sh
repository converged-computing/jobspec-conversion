#!/bin/bash
#FLUX: --job-name=spicy-gato-0923
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=16

srun 'bash' train.job ${SLURM_ARRAY_TASK_ID}
