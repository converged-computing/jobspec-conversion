#!/bin/bash
#FLUX: --job-name=fuzzy-malarkey-2803
#FLUX: --queue=courses-gpu
#FLUX: -t=300
#FLUX: --urgency=16

module purge   # unload all current modules
module load openmpi
nvcc -o GPUcode GPUcode.cu
time srun GPUcode
