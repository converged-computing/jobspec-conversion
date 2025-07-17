#!/bin/bash
#FLUX: --job-name=train_with_masks
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
MASKS_DIR=/home/s3155900/gregory/mask_caches/deeplabv3plus_resnet101
LOCAL_MSLS_DIR=/local/s3155900/acvpr-msls
LOCAL_MASKS_DIR=/local/s3155900/mask_caches/deeplabv3plus_resnet101
SYM_LOG_FILE=logs/latest.out
if [ -f "$SYM_LOG_FILE" ]; then
    echo "Removing old symlink to log file..."
    rm $SYM_LOG_FILE
fi
echo "Creating symlink to latest log file..."
LOG_FILE=$(ls -t logs/* | head -n 1)
ln -s $LOG_FILE $SYM_LOG_FILE
if [ ! -d "$LOCAL_MSLS_DIR" ]; then
    echo "Copying MSLS dataset to local scratch..."
    mkdir -p $LOCAL_MSLS_DIR
    cp -r $MSLS_DIR/. $LOCAL_MSLS_DIR
else
    echo "MSLS dataset already exists in local scratch."
fi
if [ ! -d "$LOCAL_MASKS_DIR" ]; then
    echo "Copying masks to local scratch..."
    mkdir -p $LOCAL_MASKS_DIR
    cp -r $MASKS_DIR/. $LOCAL_MASKS_DIR
else
    echo "Masks already exist in local scratch."
fi
python train.py \
    --msls_root $LOCAL_MSLS_DIR \
    --batch_size 16 \
    --epochs 100 \
    --steps 400 \
    --lr 0.1 \
    --resnext_weights /home/s3155900/gregory/utwente-acvpr-gcl_sem/MSLS_resnext_GeM_480_GCL_backbone.pth \
    --name gcl_masks \
    --masks_root $LOCAL_MASKS_DIR
    # --resume_from /home/s3155900/gregory/utwente-acvpr-gcl_sem/runs/run_8/checkpoint_30.pth \
