#!/bin/bash
#FLUX: --job-name=BRATS
#FLUX: -c=7
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

export PATH='$HOME/miniconda/bin:$PATH'

epochs=50
nvidia-smi
export PATH="$HOME/miniconda/bin:$PATH"
source activate MONAI-BRATS
ulimit -n 2048
python brats_train.py --nfolds ${SLURM_ARRAY_TASK_COUNT} --fold ${SLURM_ARRAY_TASK_ID} --epochs $epochs
