#!/bin/bash
#FLUX: --job-name=mClassifier
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module restore selfharm
source ../../reddit/bin/activate
srun python moral_classifier.py ${SLURM_ARRAY_TASK_ID}
