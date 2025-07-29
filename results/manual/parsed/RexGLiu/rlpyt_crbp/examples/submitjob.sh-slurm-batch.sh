#!/bin/bash
#SBATCH --job-name=gpu_breakout
#SBATCH --account=carney-tserre-condo
#SBATCH --output=async_gpu.out
#SBATCH --error=async_gpu_err.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem-per-cpu=100G
#SBATCH --time=8-04:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=quadrortx

module load anaconda/3-5.2.0
module load cuda/10.1.105
module load gcc/5.4
module load ninja/1.9.0
source activate torch
python breakout_example_7.py > out.txt
