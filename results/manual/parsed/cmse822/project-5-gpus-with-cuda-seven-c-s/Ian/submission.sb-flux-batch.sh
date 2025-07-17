#!/bin/bash
#FLUX: --job-name=CUDA_p1
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load gcc/7.3.0-2.30 OpenMPI HDF5
module load NVHPC
srun ./a.out
