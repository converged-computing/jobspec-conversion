#!/bin/bash
#FLUX: --job-name=pretrain-scratch-resnet152
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='/scratch/cs/sar-uav-cv/.singularity'

export SINGULARITY_CACHEDIR=/scratch/cs/sar-uav-cv/.singularity
PROJECT_ROOT="/scratch/cs/sar-uav-cv/masters-thesis"
DATASET="stanford_drone_dataset_csv"
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
    --no_weights \
    --gpu=array \
    --compute_val_loss \
    --steps=35412 \
    --epochs=50 \
    --backbone=resnet152 \
    --group=retinanet-pretrain-stanford \
    --tags=pretrain,ablation-study \
    --snapshot_interval=1 \
    --config=config.ini \
    --no_resize=true \
    --early_stop_patience=10 \
    --reduce_lr_patience=4 \
    --anchor_scale=0.965 \
    --reduce_lr_factor=0.33 \
    --seed=26203 \
    --lr=0.00002196 \
    --initial_epoch=0 \
    --loss_alpha_factor=0.25 \
    --foreground_overlap_threshold=0.5 \
    csv \
    $TMP_ROOT/data/datasets/$DATASET/train_annotations.csv \
    $TMP_ROOT/data/datasets/$DATASET/class_mapping.csv \
    --val_annotations $TMP_ROOT/data/datasets/$DATASET/val_annotations.csv
