#!/bin/bash
#SBATCH --job-name=dr5-rep
#SBATCH --output=dr5-rep_%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=0
#SBATCH --time=23:00:00
#SBATCH: --exclusive
#SBATCH --constraint=A100
#SBATCH: --no-requeue
#SBATCH --exclude=compute-0-7,compute-0-5

pwd; hostname; date
nvidia-smi
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot/bin/python
RESULTS_DIR=/share/nas2/walml/repos/gz-decals-classifiers/results
ARCHITECTURE='resnet_detectron'
BATCH_SIZE=256
GPUS=2
EXPERIMENT_DIR=$RESULTS_DIR/pytorch/dr5/${ARCHITECTURE}_dr5_pytorch_replication
DATA_DIR=/share/nas2/walml/repos/_data/decals_dr5
$PYTHON /share/nas2/walml/repos/zoobot/replication/pytorch/train_model_on_decals_dr5_splits.py \
    --experiment-dir $EXPERIMENT_DIR \
    --data-dir $DATA_DIR \
    --architecture $ARCHITECTURE \
    --resize-size 224 \
    --batch-size $BATCH_SIZE \
    --gpus $GPUS
    #  \
    # --color
    #  \
    # --mixed-precision
