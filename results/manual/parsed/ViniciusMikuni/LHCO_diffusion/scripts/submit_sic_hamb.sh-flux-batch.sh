#!/bin/bash
#FLUX: --job-name=expensive-onion-3290
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module load tensorflow
echo python classify.py --SR --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
srun python classify.py --SR  --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
