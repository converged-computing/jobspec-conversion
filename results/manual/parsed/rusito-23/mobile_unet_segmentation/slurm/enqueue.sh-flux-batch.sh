#!/bin/bash
#FLUX: --job-name=bloated-arm-9453
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

CWD=$PWD
PROJECT_PATH=$1
PYTHON_PATH=$2
CONFIG_FILE=$3
CUDA_DEVICE=$4
cd $PROJECT_PATH/slurm
srun \
    -o logs/%j.out \
    -e logs/%j.err \
    /bin/bash run.sh $PYTHON_PATH $CONFIG_FILE $CUDA_DEVICE
cd $CWD
exit 0
