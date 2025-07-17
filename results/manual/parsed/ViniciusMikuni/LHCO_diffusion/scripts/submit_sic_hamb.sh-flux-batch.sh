#!/bin/bash
#FLUX: --job-name=purple-malarkey-5212
#FLUX: -n=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=7200
#FLUX: --urgency=16

module load tensorflow
echo python classify.py --SR --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
srun python classify.py --SR  --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
