#!/bin/bash
#FLUX: --job-name=train_with_channels
#FLUX: -c=4
#FLUX: -t=82800
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)" # log hostname
echo "Working Directory = $(pwd)"
echo "Number of nodes used        : "$SLURM_NNODES
echo "Number of MPI ranks         : "$SLURM_NTASKS
echo "Number of threads           : "$SLURM_CPUS_PER_TASK
echo "Number of MPI ranks per node: "$SLURM_TASKS_PER_NODEa
echo "Number of threads per core  : "$SLURM_THREADS_PER_CORE
echo "Name of nodes used          : "$SLURM_JOB_NODELIST
echo "Gpu devices                 : "$CUDA_VISIBLE_DEVICES
echo "Starting worker: "
module load nvidia/cuda-10.1 
MSLS_DIR=/deepstore/datasets/dmb/ComputerVision/nis-data/acvpr-msls
ACTIVATIONS_DIR=/home/s3155900/gregory/mask_caches/deeplabv3plus_resnet101_all_channels_jpg
LOCAL_MSLS_DIR=/local/s3155900/acvpr-msls
LOCAL_ACTIVATIONS_DIR=/local/s3155900/mask_caches/deeplabv3plus_resnet101_all_channels_jpg
if [ ! -d "$LOCAL_MSLS_DIR" ]; then
    echo "Copying MSLS dataset to local scratch..."
    mkdir -p $LOCAL_MSLS_DIR
    cp -r $MSLS_DIR/. $LOCAL_MSLS_DIR
else
    echo "MSLS dataset already exists in local scratch."
fi
if [ ! -d "$LOCAL_ACTIVATIONS_DIR" ]; then
    echo "Copying activations to local scratch..."
    mkdir -p $LOCAL_ACTIVATIONS_DIR
    cp -r $ACTIVATIONS_DIR/. $LOCAL_ACTIVATIONS_DIR
else
    echo "Activations already exist in local scratch."
fi
python train.py \
    --msls_root $LOCAL_MSLS_DIR \
    --batch_size 16 \
    --steps 400 \
    --epochs 100 \
    --lr 0.0 \
    --first_layer_lr 0.1 \
    --resnext_weights /home/s3155900/gregory/utwente-acvpr-gcl_sem/MSLS_resnext_GeM_480_GCL_backbone.pth \
    --name gcl_channels \
    --activations_root $LOCAL_ACTIVATIONS_DIR
    # --masks_root $LOCAL_MASKS_DIR
    # --resume_from /home/s3155900/gregory/utwente-acvpr-gcl_sem/runs/run_8/checkpoint_30.pth \
