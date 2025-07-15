#!/bin/bash
#FLUX: --job-name=dinosaur-underoos-7276
#FLUX: --urgency=16

export NCCL_NSOCKS_PERTHREAD='4'
export NCCL_SOCKET_NTHREADS='2'
export WANDB_SPAWN_METHOD='fork'

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
nvidia-smi
date
squeue --job $SLURM_JOBID
echo "##### END #####"
