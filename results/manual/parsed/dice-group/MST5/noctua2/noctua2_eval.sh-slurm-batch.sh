#!/bin/bash
#SBATCH --output=eval_logs/%x_slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

set -eu
module load lib/NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load ai/PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load vis/torchvision/0.13.1-foss-2022a-CUDA-11.7.0
source mst5-venv/bin/activate
bash eval.sh "$@"
