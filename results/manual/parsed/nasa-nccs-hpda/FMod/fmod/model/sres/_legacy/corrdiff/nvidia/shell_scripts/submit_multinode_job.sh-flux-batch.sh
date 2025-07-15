#!/bin/bash
#FLUX: --job-name=my_multinode_job
#FLUX: -c=32
#FLUX: --gpus-per-task=8
#FLUX: --queue=luna
#FLUX: -t=14400
#FLUX: --priority=16

export SUBMIT_ACCOUNT='devtech'
export SHARE_SOURCE='/lustre/fsw/nvresearch/mmardani/source'
export SHARE_OUTPUT='/lustre/fsw/nvresearch/mmardani/output'
export SHARE_DATA='/lustre/fsw/nvresearch/mmardani/data'
export LOGROOT='/lustre/fsw/nvresearch/mmardani/output/logs'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load esslurm
module load pytorch/v1.10.0-gpu
export SUBMIT_ACCOUNT="devtech"
export SHARE_SOURCE="/lustre/fsw/nvresearch/mmardani/source"
export SHARE_OUTPUT="/lustre/fsw/nvresearch/mmardani/output"
export SHARE_DATA="/lustre/fsw/nvresearch/mmardani/data"
export LOGROOT="/lustre/fsw/nvresearch/mmardani/output/logs"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --label --distribution=block:block --cpu_bind=cores \
    torchrun --nnodes=1 --nproc_per_node=8 --max_restarts=3 --rdzv_id=1 \
    --rdzv_backend=c10d --rdzv_endpoint=localhost:29400 train.py \
    --batch 256 --batch-gpu 2 --augment 0.0 --arch 'ddpmpp-cwb-v0' \
    --precond 'mixture' \
    --data '/lustre/fsw/sw_climate_fno/nbrenowitz/2023-01-24-cwb-4years.zarr' \
    --outdir $LOGROOT/output --lr 2e-4 --duration 200 --snap 1 --dump 1 \
    --fp16 False --workers 4 \
    --data_config full_field_train_crop448_grid_12inchans_fcn_4outchans_4x_minmax \
    --task 'sr' --data_type 'era5-cwb-v3'
