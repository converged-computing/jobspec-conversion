#!/bin/bash
#SBATCH --job-name=MD
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gpu/gromacs/2020.1
gmx mdrun -deffnm md -v -update gpu
