#!/bin/bash
#FLUX: --job-name=astute-train-4374
#FLUX: --priority=16

export NCCL_NSOCKS_PERTHREAD='4'
export NCCL_SOCKET_NTHREADS='2'
export WANDB_SPAWN_METHOD='fork'
export OMP_NUM_THREADS='12'

cd $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"
srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date
module purge
echo "Start"
export NCCL_NSOCKS_PERTHREAD=4
export NCCL_SOCKET_NTHREADS=2
export WANDB_SPAWN_METHOD=fork
export OMP_NUM_THREADS=12
nvidia-smi
date
squeue --job $SLURM_JOBID
echo "##### END #####"
