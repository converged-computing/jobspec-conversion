#!/bin/bash
#FLUX: --job-name=chunky-lentil-0025
#FLUX: -t=108000
#FLUX: --urgency=16

epochs=100
conda activate MONAI-BRATS
nvidia-smi
python brats_train.py --nfolds ${SLURM_ARRAY_TASK_COUNT} --fold ${SLURM_ARRAY_TASK_ID} --epochs $epochs
