#!/bin/bash
#SBATCH --account=m4461_g
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu,ntasks-per-node=4

singularity
exec
ghcr.io/1tnguyen/cuda-quantum:mpich-231710
srun -N 1 -n 4 shifter bash srun_exec.sh $1 --target nvidia-mgpu
