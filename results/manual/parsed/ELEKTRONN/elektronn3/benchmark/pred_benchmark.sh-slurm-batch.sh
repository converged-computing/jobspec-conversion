#!/bin/bash
#SBATCH --job-name=E3_PRED_GPU_TEST
#SBATCH --output=./pred-out.%j
#SBATCH --error=./pred-err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./

export CUDA_VISIBLE_DEVICES='0'

module purge
module load anaconda/3/2020.02
conda activate e3
export CUDA_VISIBLE_DEVICES=0
srun python3 ./pred_benchmark.py
