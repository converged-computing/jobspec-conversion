#!/bin/bash
#SBATCH --job-name=gromacs_gpu
#SBATCH --output=gromacs_gpu.%J.stdout
#SBATCH --error=gromacs_gpu.%J.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=4096
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load compiler/gcc/10 gromacs-gpu/2023
gmx mdrun -nt 1 -nb gpu -pme gpu -bonded gpu
