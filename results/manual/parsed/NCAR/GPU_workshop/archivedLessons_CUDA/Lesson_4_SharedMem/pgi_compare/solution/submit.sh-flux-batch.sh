#!/bin/bash
#FLUX: --job-name=GPU_matmul
#FLUX: --queue=dav
#FLUX: -t=900
#FLUX: --priority=16

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'
export PCAST_COMPARE='abs=6,summary,report=5'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module list
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo ${LD_LIBRARY_PATH}
nvidia-smi
export PCAST_COMPARE=abs=6,summary,report=5
echo -e "\nBeginning code output:\n-------------\n"
srun ./matmul.exe 2048 512 512 1024
