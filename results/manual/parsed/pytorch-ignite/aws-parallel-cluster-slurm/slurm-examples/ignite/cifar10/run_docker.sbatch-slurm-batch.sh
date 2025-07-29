#!/bin/bash
#FLUX: --job-name=cifar10
#FLUX: -N=2
#FLUX: --queue=gpu-compute-ondemand
#FLUX: -t=300
#FLUX: --urgency=16

set -e
cmd="pip install --upgrade git+https://github.com/pytorch/ignite.git && python cifar10-distributed.py run --backend=nccl"
cname="/shared/enroot_data/pytorchignite+vision+latest.sqsh"
srun -l --container-name=ignite-vision --container-image=$cname --container-workdir=$PWD --no-container-remap-root bash -c "$cmd"
