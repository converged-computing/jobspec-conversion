#!/bin/bash
#SBATCH --account=project_xxxxxxxxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --partition=small-g

export ROCM_GPU='`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'` '

module reset 
module load craype-accel-amd-gfx90a 
module load rocm 
export ROCM_GPU=`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'` 
cd HPCTrainingExamples/HIPIFY/mini-nbody/cuda  
hipify-perl -inplace -print-stats nbody-orig.cu 
hipcc --offload-arch=${ROCM_GPU} -DSHMOO -I ../ nbody-orig.cu -o nbody-orig 
srun ./nbody-orig 
