#!/bin/bash
#SBATCH --job-name=hpcggpu
#SBATCH --account=sds173
#SBATCH --output=hpcg.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --mem=200000M
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --no-requeue

module reset
module load gpu
module load slurm
module load cuda
module load openmpi
mpirun -np 2 ./xhpcg-3.1_cuda-11_ompi-4.0_sm_60_sm70_sm80 
