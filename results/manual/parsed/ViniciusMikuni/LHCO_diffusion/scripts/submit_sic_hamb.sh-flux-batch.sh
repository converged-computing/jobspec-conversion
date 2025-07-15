#!/bin/bash
#FLUX: --job-name=fugly-muffin-8797
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

module load tensorflow
echo python classify.py --SR --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
srun python classify.py --SR  --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
