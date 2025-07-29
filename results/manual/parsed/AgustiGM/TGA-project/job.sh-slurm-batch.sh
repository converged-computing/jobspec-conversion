#!/bin/bash
#SBATCH --job-name=MultiGPU
#SBATCH --account=cuda
#SBATCH --output=submit-STREAMS.o%j
#SBATCH --error=submit-STREAMS.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --partition=cuda
#SBATCH --chdir=.

export PATH='/Soft/cuda/11.2.1/bin:$PATH'

export PATH=/Soft/cuda/11.2.1/bin:$PATH
./kernel00.exe 10000 Y
./kernel00.exe 300000 N
./kernel00.exe 300000 N
./kernel00.exe 300000 N
