#!/bin/bash
#FLUX: --job-name=themeda
#FLUX: -c=4
#FLUX: --queue=gpu-a100
#FLUX: -t=216000
#FLUX: --urgency=16

export PATH='/home/rturnbull/runting/poetry-py3.9.6/bin:$PATH'
export THEMEDA_DATA_DIR='/data/gpfs/projects/punim1932/data'

module purge
module load foss/2022a
module load GCCcore/11.3.0
module load Python/3.10.4
module load CUDA/12.2.0
module load cuDNN/8.9.3.28-CUDA-12.2.0
module load NCCL/2.18.3-CUDA-12.2.0
export PATH=/home/rturnbull/runting/poetry-py3.9.6/bin:$PATH
export THEMEDA_DATA_DIR=/data/gpfs/projects/punim1932/data
BATCH=1
LEARNING_RATE=0.001
KERNEL=15
EMBEDDING=16
CNN_SIZE=64
CNN_LAYERS=1
TEMPORAL_SIZE=768
TEMPORAL_LAYERS=1
SMOOTHING=0
TEMPORAL=LSTM
RUN_NAME=b${BATCH}c${KERNEL}x${CNN_SIZE}x${CNN_LAYERS}t${TEMPORAL_SIZE}x${TEMPORAL_LAYERS}sm${SMOOTHING}
poetry run themeda train \
    --input land_cover --input rain --input tmax --input elevation --input land_use \
    --input soil_ece --input soil_clay --input soil_depth \
    --output land_cover \
    --base-dir $THEMEDA_DATA_DIR \
    --validation-subset 1 \
    --batch-size $BATCH \
    --learning-rate $LEARNING_RATE \
    --embedding-size $EMBEDDING \
    --cnn-kernel $KERNEL \
    --cnn-size $CNN_SIZE \
    --cnn-layers $CNN_LAYERS \
    --temporal-processor-type $TEMPORAL \
    --temporal-size $TEMPORAL_SIZE \
    --temporal-layers $TEMPORAL_LAYERS \
    --label-smoothing $SMOOTHING \
    --run-name $RUN_NAME \
    --output-dir outputs/$RUN_NAME \
    --wandb --wandb-entity punim1932
