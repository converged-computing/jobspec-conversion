#!/bin/bash
#SBATCH --job-name=lbm2d
#SBATCH --account=CFD173
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=batch

export MPICH_GPU_SUPPORT_ENABLED='1'

module purge
module load PrgEnv-amd
module load amd/5.4.3
module load cray-mpich/8.1.26
module load craype-accel-amd-gfx90a
module load cmake/3.23.2
module list
export MPICH_GPU_SUPPORT_ENABLED=1
OMP_NUM_THREADS=7 srun -N1 -n4 -c7 --ntasks-per-node=4 ../build/mini-apps/lbm2d-letkf/thrust/lbm2d-letkf-thrust --filename letkf_512.json
