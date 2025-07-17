#!/bin/bash
#FLUX: --job-name=BayesOpt
#FLUX: -n=5
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

python optimize.py -d $1 -i ${SLURM_ARRAY_TASK_ID} -e EB
