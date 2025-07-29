#!/bin/bash
#FLUX: --job-name=nbody_benchmark
#FLUX: -n=4
#FLUX: -c=10
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1+nccl-2.8.3-1
set -x
srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python pyramid_nbody.py
