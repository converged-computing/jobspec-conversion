#!/bin/bash
#FLUX: --job-name=A100-Sngle-host
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cmake cudnn/8.9.7.29-cuda nvidia-compilers/23.9 openmpi/4.1.5-cuda
set -x
srun python $1
