#!/bin/bash
#FLUX: --job-name=nn
#FLUX: --queue=instruction
#FLUX: -t=1200
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0 gcc/.11.3.0_cuda
make clean
make
./nn
