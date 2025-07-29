#!/bin/bash
#FLUX --job-name=arid-salad-2337
#FLUX -t=300
#FLUX --urgency=16

RANDOM=$$
module load NVHPC/21.9-GCCcore-10.3.0-CUDA-11.4
nvcc final_diffusion_code.cu -o final_diffusion -O3
./final_diffusion.c
