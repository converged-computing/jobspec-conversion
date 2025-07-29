#!/bin/bash
#SBATCH --output=cuda_job.out
#SBATCH --error=cuda_job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00

module purge
module load nvidia-hpc-sdk
./gpu_miner 512 512 64
