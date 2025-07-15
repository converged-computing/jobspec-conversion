#!/bin/bash
#FLUX: --job-name=fuzzy-dog-0797
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0 gcc/.11.3.0_cuda
make clean
make
./nn
