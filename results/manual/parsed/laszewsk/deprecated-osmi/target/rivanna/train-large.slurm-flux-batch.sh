#!/bin/bash
#FLUX: --job-name=large-train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=7200
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
source $BASE/ENV3/bin/activate
cd $BASE/osmi/models
MODEL=large_tcnn
time apptainer exec --nv $CONTAINER_DIR/osmi.sif python train.py $MODEL
