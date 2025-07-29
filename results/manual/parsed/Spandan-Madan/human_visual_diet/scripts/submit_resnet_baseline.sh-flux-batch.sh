#!/bin/bash
#FLUX --job-name=blue-leopard-6438
#FLUX --queue=seas_gpu
#FLUX -t=259200
#FLUX --urgency=16

eval "$(conda shell.bash hook)"
conda activate domain_adaptation
bash resnet_baseline_ids.sh ${SLURM_ARRAY_TASK_ID}
