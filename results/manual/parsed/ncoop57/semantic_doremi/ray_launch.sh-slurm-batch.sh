#!/bin/bash
#SBATCH --job-name=semantic_doremi
#SBATCH --account=stablegpt
#SBATCH --output=raylogs/%x_%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem=999g
#SBATCH --time=1-00:00:00
#SBATCH --partition=g40
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=ip-26-0-152-47

srun --account stablegpt sh $PWD/ray_worker.sh
