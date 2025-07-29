#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:K80:1
#SBATCH --mem=7764
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load CUDA
module load MATLAB/2019a
srun matlab -nodisplay -nosplash < train_ddpg.m
