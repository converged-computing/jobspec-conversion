#!/bin/bash
#SBATCH --job-name=gpu-test
#SBATCH --output=gpu-test-%j.out
#SBATCH --error=gpu-test-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=shortvolta
#SBATCH --constraint=ntasks-per-node=1

module load cuda/10.0
module load openmpi/4.0.1-cuda10.0
srun ./cublas-streams $@
