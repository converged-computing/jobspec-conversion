#!/bin/bash
#SBATCH --job-name=test-warpx
#SBATCH --account=csc340
#SBATCH --output=test-warpx.output
#SBATCH --error=test-warpx.error
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

module load craype-accel-amd-gfx90a
module load rocm/5.1.0
module load cmake/3.22.1
module load gcc/11.2.0
module load git/2.31.1
module load git-lfs/2.11.0
module load cray-python/3.9.7.1
module load cray-mpich/8.1.15
srun -n 256 --ntasks-per-node 8 --gpus-per-node 8 ./warpx inputs_3d max_step=200 diag1.intervals=10 diag1.format=ascent
