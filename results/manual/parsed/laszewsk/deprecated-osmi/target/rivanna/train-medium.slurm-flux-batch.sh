#!/bin/bash
#FLUX: --job-name=medium-train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=3600
#FLUX: --urgency=16

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
MODEL=medium_cnn 
time apptainer exec --nv $CONTAINER_DIR/osmi.sif python train.py $MODEL
