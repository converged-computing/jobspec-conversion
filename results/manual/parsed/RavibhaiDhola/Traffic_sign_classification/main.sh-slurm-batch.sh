#!/bin/bash
#SBATCH --job-name=nas
#SBATCH --output=nas5.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=23:59:59
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
conda deactivate
conda activate new
module load python
srun python nas.py
