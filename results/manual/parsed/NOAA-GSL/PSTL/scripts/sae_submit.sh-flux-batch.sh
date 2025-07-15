#!/bin/bash
#FLUX: --job-name=faux-omelette-0655
#FLUX: --exclusive
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk/nvhpc/21.7
nvidia-smi -L
lscpu
cmake ..
make
make install
cd test
bash runall.sh
