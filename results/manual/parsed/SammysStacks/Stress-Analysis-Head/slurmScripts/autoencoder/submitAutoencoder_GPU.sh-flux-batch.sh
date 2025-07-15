#!/bin/bash
#FLUX: --job-name=goodbye-omelette-0605
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

module load intel-oneapi-mkl/2024.0.0-oneapi-2023.2.1-4aoiyez
module load cuda/11.8.0-gcc-11.3.1-nlhqhb5
module load python/3.10.12-gcc-11.3.1-n4zmj3v   # Load in the latest python version
module load openmpi/5.0.1-gcc-11.3.1-j4o6ryt    # Load in openMPI for cross-node talk
module load cuda/12.2.1-gcc-11.3.1-yfdtcdo      # Load the CUDA module
module load nvhpc/23.7-gcc-11.3.1-gifa6ml
nvcc --version
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
sh autoencoderTimeAnalysis.sh $1 $2 $3
