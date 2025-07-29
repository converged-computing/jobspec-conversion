#!/bin/bash
#SBATCH --job-name=1D
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:ampere:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

srun singularity run \
 --cleanenv \
 --env CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES \
 --nv \
 --nvccli \
 --app training_time_node \
 parametric_nn.sif \
