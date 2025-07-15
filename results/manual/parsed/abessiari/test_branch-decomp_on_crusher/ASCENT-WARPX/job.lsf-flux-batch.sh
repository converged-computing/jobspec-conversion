#!/bin/bash
#FLUX: --job-name=confused-muffin-8466
#FLUX: --priority=16

module load craype-accel-amd-gfx90a
module load rocm/5.1.0
module load cmake/3.22.1
module load gcc/11.2.0
module load git/2.31.1
module load git-lfs/2.11.0
module load cray-python/3.9.7.1
module load cray-mpich/8.1.15
srun -n 256 --ntasks-per-node 8 --gpus-per-node 8 ./warpx inputs_3d max_step=200 diag1.intervals=10 diag1.format=ascent
