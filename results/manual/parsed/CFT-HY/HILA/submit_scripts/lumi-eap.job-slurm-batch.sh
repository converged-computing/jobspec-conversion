#!/bin/bash
#SBATCH --account=Project_462000043
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --time=00:10:00

export LD_LIBRARY_PATH='$HIP_LIB_PATH:$LD_LIBRARY_PATH'
export MPICH_GPU_SUPPORT_ENABLED='1'

module load cpe/22.08 PrgEnv-cray craype-accel-amd-gfx90a cray-mpich rocm/5.0.2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=$HIP_LIB_PATH:$LD_LIBRARY_PATH
srun ./sun_realtime
