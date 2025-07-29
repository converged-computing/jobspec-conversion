#!/bin/bash
#SBATCH --output=%x_%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=0
#SBATCH --time=3-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=A100
#SBATCH --no-requeue

export NCCL_DEBUG='INFO'
export PYTORCH_KERNEL_CACHE_PATH='/share/nas2/walml/.cache/torch/kernels'

NODES=1
pwd; hostname; date
nvidia-smi
export NCCL_DEBUG=INFO
export PYTORCH_KERNEL_CACHE_PATH=/share/nas2/walml/.cache/torch/kernels
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot38_torch/bin/python
if  [ "$DATASET" = "gz_decals_dr5" ]; 
then
    DATA_DIR=/share/nas2/walml/repos/_data/gz_decals
    RESULTS_DIR=/share/nas2/walml/repos/gz-decals-classifiers/results
    EXPERIMENT_DIR=$RESULTS_DIR/benchmarks/pytorch/dr5
fi
if [ "$DATASET" = "gz_evo" ]; 
then
    DATA_DIR=/share/nas2/walml/repos/_data
    RESULTS_DIR=/share/nas2/walml/repos/gz-decals-classifiers/results
    EXPERIMENT_DIR=$RESULTS_DIR/benchmarks/pytorch/evo
fi
echo $PYTHON $ZOOBOT_DIR/benchmarks/pytorch/train_model_on_benchmark_dataset.py \
    --save-dir $EXPERIMENT_DIR/$SLURM_JOB_NAME \
    --data-dir $DATA_DIR \
    --dataset $DATASET \
    --architecture $ARCHITECTURE \
    --resize-after-crop $RESIZE_AFTER_CROP \
    --batch-size $BATCH_SIZE \
    --gpus $GPUS \
    --nodes $NODES \
    --wandb \
    --seed $SEED \
    $COLOR_STRING \
    $MIXED_PRECISION_STRING \
    $DEBUG_STRING
srun $PYTHON $ZOOBOT_DIR/benchmarks/pytorch/train_model_on_benchmark_dataset.py \
    --save-dir $EXPERIMENT_DIR/$SLURM_JOB_NAME \
    --data-dir $DATA_DIR \
    --dataset $DATASET \
    --architecture $ARCHITECTURE \
    --resize-after-crop $RESIZE_AFTER_CROP \
    --batch-size $BATCH_SIZE \
    --gpus $GPUS \
    --nodes $NODES \
    --wandb \
    --seed $SEED \
    $COLOR_STRING \
    $MIXED_PRECISION_STRING \
    $DEBUG_STRING
