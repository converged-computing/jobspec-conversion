#!/bin/bash
#FLUX: --job-name=test.omp
#FLUX: --queue=eap
#FLUX: -t=600
#FLUX: --priority=16

export LD_LIBRARY_PATH='/scratch/project_465000485/Clacc/llvm-project/install/lib:$LD_LIBRARY_PATH'

module load CrayEnv
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.2.3
export LD_LIBRARY_PATH=/scratch/project_465000485/Clacc/llvm-project/install/lib:$LD_LIBRARY_PATH
time srun ./executable.omp.exe
