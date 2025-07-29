#!/bin/bash
#SBATCH --job-name=%A_%a
#SBATCH --output=slurm_out/slurm_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4GB
#SBATCH --partition=gpu

export LD_LIBRARY_PATH='/pkgs/cuda-9.2/lib64:$LD_LIBRARY_PATH'

export LD_LIBRARY_PATH=/pkgs/cuda-9.2/lib64:$LD_LIBRARY_PATH
conda activate ift-env
echo "${SLURM_ARRAY_TASK_ID}"
python train_augment_net_slurm.py --deploy_num "${SLURM_ARRAY_TASK_ID}"
