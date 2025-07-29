#!/bin/bash
#FLUX --job-name=spicy-bike-1294
#FLUX --queue=gpu
#FLUX -t=3600
#FLUX --urgency=16

source /ssoft/spack/bin/slmodules.sh -s  x86_E5v2_Mellanox_GPU
module load gcc cuda
make
srun ./run
