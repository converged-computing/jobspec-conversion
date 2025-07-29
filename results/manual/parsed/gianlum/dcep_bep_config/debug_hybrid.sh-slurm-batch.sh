#!/bin/bash
#SBATCH --job-name=cclm-debug
#SBATCH --account=s824
#SBATCH --output=debug.out
#SBATCH --mail-user=gianluca.mussetti@env.ethz.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=12,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
srun -u ./cclm_debug
