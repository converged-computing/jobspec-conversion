#!/bin/bash
#FLUX: --job-name=bwe_progressive_half_size
#FLUX: -c=4
#FLUX: -t=259199
#FLUX: --priority=16

export TORCH_USE_RTLD_GLOBAL='YES'

module load anaconda 
source activate /scratch/work/molinee2/conda_envs/2022_torchot
export TORCH_USE_RTLD_GLOBAL=YES
n=3
PATH_EXPERIMENT=experiments_bwe/${n}
mkdir $PATH_EXPERIMENT
python train_bwe.py path_experiment="$PATH_EXPERIMENT"   #override here the desired parameters using hydra
