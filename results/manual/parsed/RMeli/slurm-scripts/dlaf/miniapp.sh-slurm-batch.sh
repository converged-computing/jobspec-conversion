#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=nvgpu

module use /user-environment/modules
module --ignore-cache load intel-mkl
miniapp=miniapp/miniapp_eigensolver
nvidia-smi
ms=16384
for bs in 256 512 1024
do
    echo -e "\n\nRUNNING ${miniapp} --matrix-size ${ms} --block-size=${bs}\n"
    ${miniapp} --matrix-size ${ms} --block-size ${bs}
done
