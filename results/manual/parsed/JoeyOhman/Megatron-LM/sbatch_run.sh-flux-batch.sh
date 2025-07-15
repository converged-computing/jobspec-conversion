#!/bin/bash
#FLUX: --job-name=Megatron-BERT
#FLUX: -N=16
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export WANDB_ENTITY='joeyohman'
export WANDB_PROJECT='megatron_bert'
export WANDB_MODE='offline'
export MASTER_ADDR='$addr'
export MASTER_PORT='56782'
export NPROC_PER_NODE='$SLURM_GPUS_PER_NODE'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

echo "Inside sbatch_run.sh script..."
wandb login 0fc05c8f0ff7f9219378a081a69de35fc26c1011
export WANDB_ENTITY=joeyohman
export WANDB_PROJECT=megatron_bert
export WANDB_MODE=offline
module purge
pwd
addr=$(/bin/hostname -s)
export MASTER_ADDR=$addr
export MASTER_PORT=56782
export NPROC_PER_NODE=$SLURM_GPUS_PER_NODE
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
DATETIME=$(date +'date_%y-%m-%d_time_%H-%M-%S')
PROJECT=/ceph/hpc/home/eujoeyo/group_space/joey/workspace/Megatron-LM
TARGET_DIR="/workspace/Megatron-LM"
CONTAINER_PATH="/ceph/hpc/home/eujoeyo/group_space/containers/megatron-deepspeed.sif"
LOGGING=$PROJECT/logs
echo "MASTER_ADDR" $MASTER_ADDR
echo "MASTER_PORT" $MASTER_PORT
echo "NPROC_PER_NODE" $NPROC_PER_NODE
echo "SLURM_JOB_NAME" $SLURM_JOB_NAME
echo "SLURM_JOB_ID" $SLURM_JOB_ID
echo "SLURM_JOB_NODELIST" $SLURM_JOB_NODELIST
echo "SLURM_JOB_NUM_NODES" $SLURM_JOB_NUM_NODES
echo "SLURM_LOCALID" $SLURM_LOCALID
echo "SLURM_NODEID" $SLURM_NODEID
echo "SLURM_PROCID" $SLURM_PROCID
cmd="srun -l --output=$LOGGING/srun_$DATETIME.log \
  singularity exec --nv --pwd /workspace/Megatron-LM --bind $PROJECT:$TARGET_DIR $CONTAINER_PATH ./start_training_large.sh"
echo "Executing:"
echo $cmd
$cmd
set +x
exit 0
