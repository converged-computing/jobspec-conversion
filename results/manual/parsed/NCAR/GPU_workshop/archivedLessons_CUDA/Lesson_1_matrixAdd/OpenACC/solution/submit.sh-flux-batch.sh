#!/bin/bash
#FLUX: --job-name=GPU_matrix_add
#FLUX: --queue=dav
#FLUX: -t=900
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module load cuda/11.0.3
module list
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo ${LD_LIBRARY_PATH}
nvidia-smi
echo -e "\nBeginning code output:\n-------------\n"
srun nvprof -f -o matrix_add.nvvp ./matrix_add.exe
