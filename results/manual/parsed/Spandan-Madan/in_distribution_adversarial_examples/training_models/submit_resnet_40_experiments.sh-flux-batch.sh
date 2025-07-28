#!/bin/bash
#FLUX: --job-name=resnet_40_experiments
#FLUX: -c=2
#FLUX: --queue=cbmm
#FLUX: -t=180000
#FLUX: --urgency=16

bash resnet_40_experiments.sh ${SLURM_ARRAY_TASK_ID}
