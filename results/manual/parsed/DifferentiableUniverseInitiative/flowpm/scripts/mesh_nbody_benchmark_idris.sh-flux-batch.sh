#!/bin/bash
#FLUX: --job-name=nbody_benchmark
#FLUX: -n=16
#FLUX: -c=10
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1+nccl-2.8.3-1
set -x
srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python mesh_nbody_benchmark.py --nc=512 --batch_size=1 --nx=4 --ny=4 --hsize=32
