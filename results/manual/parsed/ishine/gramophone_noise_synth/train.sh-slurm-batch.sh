#!/bin/bash
#SBATCH --job-name=diffwave
#SBATCH --output=/scratch/work/%u/projects/ddpm/CRASH/experiments/%a/train_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10G
#SBATCH --time=2-23:59:59
#SBATCH --array=[23]

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
