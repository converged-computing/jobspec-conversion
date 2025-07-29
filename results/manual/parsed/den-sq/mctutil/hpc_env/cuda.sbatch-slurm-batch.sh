#!/bin/bash
#SBATCH --job-name=GPUJob
#SBATCH --output=GPUJob_results.%j.%N.txt
#SBATCH --error=GPUJob_errors.%j.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:2
#SBATCH --partition=gpu

module load miniconda/3
module load cuda
source activate recon
srun nvidia-smi
python cuda.py
