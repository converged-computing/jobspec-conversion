#!/bin/bash
#FLUX: --job-name=arid-spoon-6949
#FLUX: --priority=16

module load nvidia/cuda/11.8.0 gcc/.11.3.0_cuda
make clean
make
./nn
