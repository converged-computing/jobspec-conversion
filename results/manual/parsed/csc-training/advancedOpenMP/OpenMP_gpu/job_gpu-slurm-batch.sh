#!/bin/bash
#SBATCH --job-name=omp_gpu
#SBATCH --account=project_462000390
#SBATCH --output=%x.out%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:mi250:1
#SBATCH --time=00:05:00

export OMP_NUM_THREADS='3'
export CRAY_ACC_DEBUG='2   # use 1 for less, or 3 for FULL'

export OMP_NUM_THREADS=3
ml LUMI/23.03
ml partition/G craype-accel-amd-gfx90a craype-x86-trento rocm
export CRAY_ACC_DEBUG=2   # use 1 for less, or 3 for FULL
                          #                 to see everything!
./a.out
