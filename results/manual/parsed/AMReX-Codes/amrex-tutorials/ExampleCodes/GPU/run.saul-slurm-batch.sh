#!/bin/bash
#SBATCH --job-name=AMReX
#SBATCH --account=mXXXX_g
#SBATCH --output=AMReX.o%j
#SBATCH --error=AMReX.e%j
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu,ntasks-per-node=4

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
