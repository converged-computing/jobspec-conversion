#!/bin/bash
#FLUX: --job-name=diffwave
#FLUX: -t=259199
#FLUX: --urgency=16

export TORCH_USE_RTLD_GLOBAL='YES'
export HYDRA_FULL_ERROR='1'
export CUDA_LAUNCH_BLOCKING='1'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/2022_torchot
export TORCH_USE_RTLD_GLOBAL=YES
export HYDRA_FULL_ERROR=1
export CUDA_LAUNCH_BLOCKING=1
PATH_EXPERIMENT=experiments/trained_model
mkdir $PATH_EXPERIMENT
python train.py model_dir="$PATH_EXPERIMENT"
