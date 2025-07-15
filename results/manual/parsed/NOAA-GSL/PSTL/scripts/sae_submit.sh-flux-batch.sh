#!/bin/bash
#FLUX: --job-name=confused-carrot-1012
#FLUX: --exclusive
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk/nvhpc/21.7
nvidia-smi -L
lscpu
cmake ..
make
make install
cd test
bash runall.sh
