#!/bin/bash
#SBATCH --output=gmx_run-%A.%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
srun gmx mdrun -deffnm gromacs -c gromacs_out.gro
