#!/bin/bash
#FLUX: --job-name=train-vgg16
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='/scratch/cs/sar-uav-cv/.singularity'

export SINGULARITY_CACHEDIR=/scratch/cs/sar-uav-cv/.singularity
PROJECT_ROOT="/scratch/cs/sar-uav-cv/masters-thesis"
DATASET="heridal_keras_retinanet_voc_tiled"
TMP_ROOT="/tmp/${SLURM_JOB_ID}"
mkdir -p $TMP_ROOT/data/datasets/
cp $PROJECT_ROOT/data/datasets/$DATASET.tar $TMP_ROOT/data/datasets/
trap "rm -rf ${TMP_ROOT}; echo 'quit' | nvidia-cuda-mps-control; exit" TERM EXIT
tar -Uxf $TMP_ROOT/data/datasets/$DATASET.tar -C $TMP_ROOT/data/datasets/
module load nvidia-tensorflow/20.02-tf1-py3
CUDA_MPS_LOG_DIRECTORY=nvidia-mps srun --gres=gpu:1 nvidia-cuda-mps-control -d&
srun singularity exec --nv -B $PROJECT_ROOT keras-retinanet-gpu.simg \
    /bin/bash $PROJECT_ROOT/computer_vision/keras-retinanet/train.sh \
    --random_transform=false \
    --gpu=array \
    --anchor_scale=0.965 \
    --config=config.ini \
    --early_stop_patience=10 \
    --image_max_side=2025 \
    --image_min_side=1525 \
    --lr=0.00002196 \
    --seed=26203 \
    --reduce_lr_factor=0.33 \
    --reduce_lr_patience=4 \
    --no_resize=true \
    --compute_val_loss \
    --steps=5564 \
    --epochs=20 \
    --backbone=vgg16 \
    --group=retinanet-train-model-selection \
    --tags=model-selection \
    --snapshot_interval=1 \
    --seed=26203 \
    pascal \
    $TMP_ROOT/data/datasets/$DATASET
