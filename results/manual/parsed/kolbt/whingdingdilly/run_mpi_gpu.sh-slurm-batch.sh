#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=32G
#SBATCH --time=11-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=gpu_access

filename=$1
mpirun -n 2 python $filename --mode=gpu     # I want two gpus
