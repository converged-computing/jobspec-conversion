#!/bin/bash
#SBATCH --job-name=scc
#SBATCH --account=ka1273
#SBATCH --output=%x.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --partition=gpu
#SBATCH: --exclusive

export LD_LIBRARY_PATH='/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/profilers/Nsight_Systems/host-linux-x64/:/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/cuda/lib64'

ulimit -s unlimited
ulimit -c 0
. scripts/levante-setup.sh nvidia gpu
export LD_LIBRARY_PATH=/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/profilers/Nsight_Systems/host-linux-x64/:/sw/spack-levante/nvhpc-23.7-xasprs/Linux_x86_64/23.7/cuda/lib64
ncu --set full --metric all --export ncu-report build/bin/graupel $1
