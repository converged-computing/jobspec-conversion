#!/bin/bash
#FLUX: --job-name=bricky-egg-8727
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=eap
#FLUX: -t=600
#FLUX: --priority=16

export LD_LIBRARY_PATH='$HIP_LIB_PATH:$LD_LIBRARY_PATH'
export MPICH_GPU_SUPPORT_ENABLED='1'

module load cpe/22.08 PrgEnv-cray craype-accel-amd-gfx90a cray-mpich rocm/5.0.2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=$HIP_LIB_PATH:$LD_LIBRARY_PATH
srun ./sun_realtime
