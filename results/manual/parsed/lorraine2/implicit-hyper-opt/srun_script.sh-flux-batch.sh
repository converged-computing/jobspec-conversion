#!/bin/bash
#FLUX: --job-name=%A_%a
#FLUX: --priority=16

export LD_LIBRARY_PATH='/pkgs/cuda-9.2/lib64:$LD_LIBRARY_PATH'

export LD_LIBRARY_PATH=/pkgs/cuda-9.2/lib64:$LD_LIBRARY_PATH
conda activate ift-env
echo "${SLURM_ARRAY_TASK_ID}"
python train_augment_net_slurm.py --deploy_num "${SLURM_ARRAY_TASK_ID}"
