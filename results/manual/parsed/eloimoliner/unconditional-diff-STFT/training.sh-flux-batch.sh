#!/bin/bash
#FLUX: --job-name=unet2d_diff_strings
#FLUX: -c=4
#FLUX: -t=172799
#FLUX: --urgency=16

export TORCH_USE_RTLD_GLOBAL='YES'
export HYDRA_FULL_ERROR='1'
export CUDA_LAUNCH_BLOCKING='1'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/2022_torchot
export TORCH_USE_RTLD_GLOBAL=YES
export HYDRA_FULL_ERROR=1
export CUDA_LAUNCH_BLOCKING=1
python train.py model_dir="experiments/strings" batch_size=8 microbatches=1 save_interval=50000 unet2d.use_attention=True dset=strings
