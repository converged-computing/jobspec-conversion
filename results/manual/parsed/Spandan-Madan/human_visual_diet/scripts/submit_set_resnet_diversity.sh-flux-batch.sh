#!/bin/bash
#FLUX: --job-name=bricky-blackbean-9933
#FLUX: --queue=seas_gpu,gpu,cox
#FLUX: -t=259200
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate python_env1
bash set_resnet_diversity.sh ${SLURM_ARRAY_TASK_ID}
