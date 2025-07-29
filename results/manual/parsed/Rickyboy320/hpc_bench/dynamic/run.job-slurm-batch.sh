#!/bin/bash
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

module load mpich/ge/gcc/64/3.2
module load cuda10.0/toolkit/10.0.130
which mpirun
which mpiexec
mpirun -n 3 ./vector.out "$@"
