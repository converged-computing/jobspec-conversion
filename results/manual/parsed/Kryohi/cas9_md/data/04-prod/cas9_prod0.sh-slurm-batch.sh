#!/bin/bash
#SBATCH --job-name=cas9_nvt
#SBATCH --output=stack.txt
#SBATCH --error=stack.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='16'

module load gromacs/2020.4
export OMP_NUM_THREADS=16
gmx mdrun -s cas9_prod0.tpr -v -ntmpi 1 -deffnm cas9_prod0
