#!/bin/bash
#FLUX: --job-name=train-cosmoflow
#FLUX: -c=4
#FLUX: --queue=bii-gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export SIF_DIR='/scratch/$USER/cosmoflow'
export USER_CONTAINER_DIR='/scratch/$USER/.singularity'
export COSMOFLOW='$SIF_DIR/hpc/cosmoflow'

module purge
module load singularity
export SIF_DIR=/scratch/$USER/cosmoflow
export USER_CONTAINER_DIR=/scratch/$USER/.singularity
export COSMOFLOW=$SIF_DIR/hpc/cosmoflow
cd $SIF_DIR
singularity run --nv $USER_CONTAINER_DIR/cosmoflow-gpu_mlperf-v1.0.sif $SIF_DIR/train.py
