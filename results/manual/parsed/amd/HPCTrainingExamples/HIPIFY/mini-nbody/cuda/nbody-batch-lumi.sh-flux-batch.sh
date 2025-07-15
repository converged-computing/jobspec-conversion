#!/bin/bash
#FLUX: --job-name=hello-motorcycle-7100
#FLUX: --priority=16

export ROCM_GPU='`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'` '

module reset 
module load craype-accel-amd-gfx90a 
module load rocm 
export ROCM_GPU=`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'` 
cd HPCTrainingExamples/HIPIFY/mini-nbody/cuda  
hipify-perl -inplace -print-stats nbody-orig.cu 
hipcc --offload-arch=${ROCM_GPU} -DSHMOO -I ../ nbody-orig.cu -o nbody-orig 
srun ./nbody-orig 
