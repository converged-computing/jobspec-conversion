#!/bin/bash
#FLUX: --job-name=buttery-parrot-3066
#FLUX: --queue=seas_gpu,gpu,cox
#FLUX: -t=259200
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate python_env1
bash set_resnet_diversity.sh ${SLURM_ARRAY_TASK_ID}
