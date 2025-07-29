#!/bin/bash
#FLUX: --job-name=large-train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=7200
#FLUX: --urgency=16

NAME=cloudmesh-rivanna
PROJECT_DIR=$PROJECT/osmi
RUN_DIR=$PROJECT_DIR/target/rivanna
MODEL_DIR=$PROJECT_DIR/models
module purge
module load singularity
nvidia-smi
source $PROJECT_DIR/ENV3/bin/activate
cd $MODEL_DIR
MODEL=large_tcnn
time singularity exec --nv $RUN_DIR/$NAME.sif python train.py $model
