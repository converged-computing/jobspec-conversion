#!/bin/bash
#SBATCH --job-name=hw6
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

source ~/.bashrc
module load cuda
module load openmpi
module load gcc/8.3.0-wbma
nvidia-smi
cd /users/bienz/cs-442-542-f20/heterogenenous
mpirun -n 16 ./hello_world
