#!/bin/bash
#FLUX: --job-name=cowy-truffle-7547
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/share/nas2/walml/miniconda3/envs/zoobot38_tf/lib/'

pwd; hostname; date
export LD_LIBRARY_PATH=/share/nas2/walml/miniconda3/envs/zoobot38_tf/lib/
nvidia-smi
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot38_tf/bin/python
if  [ "$DATASET" = "gz_decals_dr5" ]; 
then
    DATA_DIR=/share/nas2/walml/repos/_data/gz_decals
    RESULTS_DIR=/share/nas2/walml/repos/gz-decals-classifiers/results
    EXPERIMENT_DIR=$RESULTS_DIR/benchmarks/tensorflow/dr5
fi
if [ "$DATASET" = "gz_evo" ]; 
then
    DATA_DIR=/share/nas2/walml/repos/_data
    RESULTS_DIR=/share/nas2/walml/repos/gz-decals-classifiers/results
    EXPERIMENT_DIR=$RESULTS_DIR/benchmarks/tensorflow/evo
fi
ARCHITECTURE='efficientnet'
BATCH_SIZE=512  # equivalent to 256 on PyTorch, with 2 GPUs
echo $ZOOBOT_DIR/benchmarks/tensorflow/train_model_on_benchmark_dataset.py \
    --save-dir $EXPERIMENT_DIR/$SLURM_JOB_NAME \
    --data-dir $DATA_DIR \
    --dataset $DATASET \
    --architecture $ARCHITECTURE \
    --resize-after-crop 224 \
    --batch-size $BATCH_SIZE \
    --gpus $GPUS \
    --wandb \
    --seed $SEED \
    $COLOR_STRING \
    $MIXED_PRECISION_STRING \
    $DEBUG_STRING
$PYTHON $ZOOBOT_DIR/benchmarks/tensorflow/train_model_on_benchmark_dataset.py \
    --save-dir $EXPERIMENT_DIR/$SLURM_JOB_NAME \
    --data-dir $DATA_DIR \
    --dataset $DATASET \
    --architecture $ARCHITECTURE \
    --resize-after-crop 300 \
    --batch-size $BATCH_SIZE \
    --gpus $GPUS \
    --wandb \
    --seed $SEED \
    $COLOR_STRING \
    $MIXED_PRECISION_STRING \
    $DEBUG_STRING
