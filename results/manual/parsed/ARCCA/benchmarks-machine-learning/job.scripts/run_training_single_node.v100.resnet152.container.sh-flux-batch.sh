#!/bin/bash
#FLUX: --job-name=tart-peas-2660
#FLUX: --urgency=16

set -eu
module purge
module load singularity
module list
IMAGEPATH=/scratch/c.c1045890/dl.examples/pytorch/nvidia.ngc.containers
IMAGENAME=pytorch-22.03-py3
WORKDIR=/scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/outputs/resnet152/$SLURM_JOB_ID
rm -rf $WORKDIR
mkdir -p $WORKDIR
code="main_amp.py"
cp $code $WORKDIR
cd $WORKDIR
env
time singularity run --nv ${IMAGEPATH}/${IMAGENAME} python3 -u -m \
    torch.distributed.launch --nproc_per_node=2 $code \
    -a resnet152 \
    --batch-size 128 \
    --workers 8 \
    --epochs 3 \
    --print-freq 100 \
    --opt-level O1 \
    /scratch/c.c1045890/dl.examples/pytorch/examples/imagenet/rawdata
