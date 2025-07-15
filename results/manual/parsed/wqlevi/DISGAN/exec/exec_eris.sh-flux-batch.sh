#!/bin/bash
#FLUX: --job-name=persnickety-muffin-2663
#FLUX: -t=86400
#FLUX: --urgency=16

HOME_DIR='/u/wangqi'
SRC_DIR='/u/wangqi/git_wq/3d_super-resolution_mri/mains'
DATA_DIR='/ptmp/wangqi/LS_all/crops'
module purge 
module load anaconda/3/2021.11
module load gcc/11
module load openmpi/4
module load pytorch-distributed/gpu-cuda-11.6/2.0.0
module load pytorch-lightning/2.0.1
srun python ln_DDP_train.py --model_name 'DWT_D'
echo "Jobs finished"
