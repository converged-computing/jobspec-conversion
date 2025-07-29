#!/bin/bash
#SBATCH --job-name=bwe_progressive_half_size
#SBATCH --output=/scratch/work/%u/unet_dir/bwe_historical_recordings/experiments/%a_training_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10G
#SBATCH --time=2-23:59:59
#SBATCH --array=[2]

export TORCH_USE_RTLD_GLOBAL='YES'

module load anaconda 
source activate /scratch/work/molinee2/conda_envs/2022_torchot
export TORCH_USE_RTLD_GLOBAL=YES
n=3
PATH_EXPERIMENT=experiments_bwe/${n}
mkdir $PATH_EXPERIMENT
python train_bwe.py path_experiment="$PATH_EXPERIMENT"   #override here the desired parameters using hydra
