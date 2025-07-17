#!/bin/bash
#FLUX: --job-name=V100-Multi-host
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=10
#FLUX: -t=240
#FLUX: --urgency=16

export MODULEPATH='$NVHPC/modulefiles:$MODULEPATH'

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cudnn/8.9.7.29-cuda cmake nvidia-compilers/23.9
export MODULEPATH=$NVHPC/modulefiles:$MODULEPATH
module load nvhpc-hpcx-cuda11/23.9
set -x
srun python -m pytest $1
