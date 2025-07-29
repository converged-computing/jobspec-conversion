#!/bin/bash
#FLUX: --job-name=Learning-jax-SPMD
#FLUX: -N=2
#FLUX: -c=10
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load nvidia-compilers/23.9 cuda/11.8.0 cudnn/8.9.7.29-cuda  openmpi/4.1.1-cuda nccl/2.18.1-1-cuda cmake
module load python/3.10.4 && conda deactivate
source venv/bin/activate
set -x
srun python $1
