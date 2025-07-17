#!/bin/bash
#FLUX: --job-name=lovely-bicycle-8694
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

module load intel-oneapi-mkl/2023.2.0-gcc-11.3.1-6dhawvh
module load openmpi/4.1.5-gcc-13.2.0-24q3ap2    # Load in openMPI for cross-node talk
module load cuda/12.1.1-gcc-13.2.0-vjpligh      # Load the CUDA module
module load nvhpc/23.7-gcc-11.3.1-gifa6ml
nvcc --version
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
sh signalencoderGroupAnalysis.sh "$1" "$2" "$3" "$4" "$5"
