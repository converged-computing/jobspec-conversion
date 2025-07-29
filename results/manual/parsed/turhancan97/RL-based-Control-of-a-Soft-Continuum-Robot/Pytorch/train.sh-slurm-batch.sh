#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=experiment/results_train.txt
#SBATCH --error=experiment/errors.txt
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:01
#SBATCH --nodelist=xeon-09

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

conda init bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate continuum-rl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
python ddpg.py
