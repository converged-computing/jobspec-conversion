#!/bin/bash
#SBATCH --account=stf007uanofn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=batch

module load PrgEnv-amd
module load craype-accel-amd-gfx90a
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/vAdd_hip
