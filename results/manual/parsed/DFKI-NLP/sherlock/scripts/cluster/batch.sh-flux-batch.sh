#!/bin/bash
#FLUX: --job-name=test
#FLUX: --gpus-per-task=1
#FLUX: --queue=RTXA6000
#FLUX: --urgency=16

username="$USER"
IMAGE=/netscratch/enroot/nvcr.io_nvidia_pytorch_21.10-py3.sqsh
WORKDIR="`pwd`"
srun 2>&1 -K --container-mounts=/netscratch/$USER:/netscratch/$USER,/netscratch/$USER/.cache_slurm:/root/.cache,/ds:/ds:ro,"`pwd`":"`pwd`" \
--container-image=$IMAGE \
--container-workdir=$WORKDIR \
--ntasks=1 \
--nodes=1 \
--cpus-per-task=1 \
$*
