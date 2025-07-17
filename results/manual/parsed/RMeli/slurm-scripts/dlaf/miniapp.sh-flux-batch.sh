#!/bin/bash
#FLUX: --job-name=boopy-lemon-8980
#FLUX: -N=4
#FLUX: --queue=nvgpu
#FLUX: --urgency=16

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
