#!/bin/bash
#FLUX: --job-name=t-lightning
#FLUX: -c=5
#FLUX: --queue=GPU
#FLUX: -t=172800
#FLUX: --urgency=16

srun 'bash' train.job ${SLURM_ARRAY_TASK_ID}
