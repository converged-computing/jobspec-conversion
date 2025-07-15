#!/bin/bash
#FLUX: --job-name=confused-lamp-1075
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --priority=16

srun 'bash' train.job ${SLURM_ARRAY_TASK_ID}
