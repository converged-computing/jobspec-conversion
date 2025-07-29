#!/bin/bash
#FLUX: --job-name=lovable-mango-6152
#FLUX: --exclusive
#FLUX: --queue=epyc_a100x4
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
