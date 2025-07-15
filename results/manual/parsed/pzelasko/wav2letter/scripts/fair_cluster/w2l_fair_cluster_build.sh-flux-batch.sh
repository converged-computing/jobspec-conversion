#!/bin/bash
#FLUX: --job-name=wav2letter-build
#FLUX: -c=32
#FLUX: --queue=priority
#FLUX: -t=43200
#FLUX: --priority=16

export CMAKE_PREFIX_PATH='$HOME/usr'

module purge
module load cuda/9.2
module load cudnn/v7.1-cuda.9.2
module load NCCL/2.2.13-1-cuda.9.2
module load mkl/2018.0.128
module load openmpi/3.0.0/gcc.6.3.0
module load kenlm/110617/gcc.6.3.0
export CMAKE_PREFIX_PATH="$HOME/usr"
cd "$HOME/wav2letter/build/" && cmake .. && make -j32
