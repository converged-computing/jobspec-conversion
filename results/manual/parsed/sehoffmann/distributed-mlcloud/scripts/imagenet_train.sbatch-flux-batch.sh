#!/bin/bash
#FLUX: --job-name=ImageNet
#FLUX: -t=57600
#FLUX: --priority=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
ARGS+=" --project-name=imagenet"
ARGS+=" --data=/mnt/qb/datasets/ImageNet2012/"
ARGS+=" --direct-path"
srun --mpi=pmix dmlcloud-train imagenet $ARGS ${@:1}
