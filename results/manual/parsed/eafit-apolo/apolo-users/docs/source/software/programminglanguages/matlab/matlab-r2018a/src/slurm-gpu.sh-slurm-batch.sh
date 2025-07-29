#!/bin/bash
#SBATCH --job-name=test_matlab
#SBATCH --output=test_matlab-gpu-%j.out
#SBATCH --error=test_matlab-gpu-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=00:20:00

module load matlab/r2018a
matlab -nosplash -nodesktop < gpu_script.m
