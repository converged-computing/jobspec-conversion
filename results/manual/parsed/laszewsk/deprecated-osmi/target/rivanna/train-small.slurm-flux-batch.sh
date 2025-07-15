#!/bin/bash
#FLUX: --job-name=small-train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=1800
#FLUX: --priority=16

export CONTAINER_DIR='$EXEC_DIR/image-apptainer/'

if [ -z "$EXEC_DIR" ]; then
    echo "EXEC_DIR is not set"
    exit 1
fi
export CONTAINER_DIR=$EXEC_DIR/image-apptainer/
module purge
module load apptainer
nvidia-smi
cd $BASE/osmi/models
MODEL=small_lstm 
time apptainer exec --nv $CONTAINER_DIR/osmi.sif python train.py $MODEL
