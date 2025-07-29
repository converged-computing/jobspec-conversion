#!/bin/bash
#FLUX --job-name=creamy-cat-7181
#FLUX --queue=courses-gpu
#FLUX -t=300
#FLUX --urgency=16

module purge   # unload all current modules
module load openmpi
nvcc -o GPUcode GPUcode.cu
time srun GPUcode
