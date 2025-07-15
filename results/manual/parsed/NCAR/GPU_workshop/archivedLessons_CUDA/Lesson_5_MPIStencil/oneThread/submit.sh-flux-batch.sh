#!/bin/bash
#FLUX: --job-name=GPU_stncl
#FLUX: --queue=dav
#FLUX: -t=900
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}'
export NV_ACC_TIME='1'

module purge
module load ncarenv/1.2
module load nvhpc/20.11
module load cuda/11.0.3
module list
echo -e "nvidia-smi output follows:"
nvidia-smi
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo -e "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
export NV_ACC_TIME=1
echo -e "\nBeginning code output:\n-------------\n"
srun ./acc_stencil.exe
echo -e "\nEnd of code output:\n-------------\n"
