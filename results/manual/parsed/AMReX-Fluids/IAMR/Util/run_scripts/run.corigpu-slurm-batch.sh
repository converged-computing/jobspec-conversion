#!/bin/bash
#SBATCH --job-name=AMREX_GPU
#SBATCH --account=m3406
#SBATCH --output=AMREX_GPU.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:8
#SBATCH --time=00:05:00
#SBATCH --constraint=gpu,ntasks-per-node=8

EXE=./main3d.gnu.TPROF.MPI.CUDA.ex
INPUTS=inputs
srun ${EXE} ${INPUTS}
