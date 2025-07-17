#!/bin/bash
#FLUX: --job-name=TEST
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='12'

module purge
module load gcc/12
module load FFTW/3.3.10
module load OpenBLAS/0.3.23
module load openmpi-cuda/4.1.5
module load nvhpc/23.3
module load CUDA/12.1
module load intel/oneapi-2023.1.0
module load compiler/2023.1.0
module load mkl/2023.1.0
source $HOME/flare/bin/activate
nvidia-cuda-mps-control -d
export OMP_NUM_THREADS=12
flare-otf inputs.yaml
