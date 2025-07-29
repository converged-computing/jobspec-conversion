#!/bin/bash
#SBATCH --job-name=modeltrainer
#SBATCH --mail-user=muddi004@odu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

enable_lmod
module load container_env pytorch-gpu/1.9.0
crun -p ~/envs/citationparser python reshad.py
