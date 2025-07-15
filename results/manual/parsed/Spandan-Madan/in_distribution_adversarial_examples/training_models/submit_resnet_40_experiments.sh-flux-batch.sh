#!/bin/bash
#FLUX: --job-name=gassy-snack-5372
#FLUX: --queue=cbmm
#FLUX: --priority=16

bash resnet_40_experiments.sh ${SLURM_ARRAY_TASK_ID}
