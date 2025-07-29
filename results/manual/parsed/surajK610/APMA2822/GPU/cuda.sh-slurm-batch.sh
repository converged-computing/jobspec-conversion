#!/bin/bash
#FLUX: --job-name=hanky-poodle-2361
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

module load cuda/12.2.2  gcc/10.2
nvidia-smi
nvcc -O2 secDeriv.cu -o output/secDeriv
nvprof ./output/secDeriv
