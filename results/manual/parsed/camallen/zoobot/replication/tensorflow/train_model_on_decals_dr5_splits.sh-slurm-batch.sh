#!/bin/bash
#FLUX: --job-name=dr5-rep-tf
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=82800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64'

pwd; hostname; date
nvidia-smi
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot/bin/python
TFRECORD_DIR=/share/nas2/walml/repos/gz-decals-classifiers/data/decals/shards/all_2p5_unfiltered_n2
TRAIN_DIR=$TFRECORD_DIR/train_shards
TEST_DIR=$TFRECORD_DIR/eval_shards
THIS_DIR=/share/nas2/walml/repos/gz-decals-classifiers
EXPERIMENT_DIR=$THIS_DIR/results/tensorflow/dr5/efficientnet_dr5_tensorflow_greyscale
$PYTHON $ZOOBOT_DIR/zoobot/tensorflow/examples/train_model_on_shards.py \
    --experiment-dir $EXPERIMENT_DIR \
    --shard-img-size 300 \
    --resize-size 224 \
    --train-dir $TRAIN_DIR \
    --test-dir $TEST_DIR \
    --epochs 200 \
    --batch-size 512 \
    --gpus 2  \
    --wandb
