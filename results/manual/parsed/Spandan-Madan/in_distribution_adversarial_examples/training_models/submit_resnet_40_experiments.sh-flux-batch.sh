#!/bin/bash
#FLUX: --job-name=anxious-lettuce-0494
#FLUX: --queue=cbmm
#FLUX: --urgency=16

bash resnet_40_experiments.sh ${SLURM_ARRAY_TASK_ID}
