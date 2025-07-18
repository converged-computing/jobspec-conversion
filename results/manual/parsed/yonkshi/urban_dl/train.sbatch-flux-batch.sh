#!/bin/bash
#FLUX: --job-name=blue-leg-3642
#FLUX: -c=4
#FLUX: --urgency=16

echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate project_env
python train.py --cuda --learning-rate ${LEARNING_RATE} --epochs ${EPOCHS}
. ~/miniconda3/etc/profile.d/conda.sh
conda activate gpu2
python train_xview2.py -c ${CONFIG_NAME}
