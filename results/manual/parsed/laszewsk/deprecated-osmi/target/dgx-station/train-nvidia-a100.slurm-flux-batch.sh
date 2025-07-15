#!/bin/bash
#FLUX: --job-name=train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=7200
#FLUX: --priority=16

NAME=cloudmesh-nvidia
PROJECT_DIR="$PROJECT/osmi"
RUN_DIR="$PROJECT_DIR/machine/rivanna"
MODEL_DIR="$PROJECT_DIR/models"
module purge
module load singularity
nvidia-smi
source $PROJECT_DIR/ENV3/bin/activate
cd $MODEL_DIR
singularity exec --nv $RUN_DIR/$NAME.sif python train.py small_lstm
