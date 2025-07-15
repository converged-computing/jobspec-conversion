#!/bin/bash
#FLUX: --job-name=Preprocess-Megatron-BERT
#FLUX: -c=128
#FLUX: --queue=cpu
#FLUX: -t=43200
#FLUX: --priority=16

export MASTER_ADDR='$addr'
export MASTER_PORT='56781'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

echo "Inside sbatch_run.sh script..."
addr=$(/bin/hostname -s)
export MASTER_ADDR=$addr
export MASTER_PORT=56781
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
DATETIME=$(date +'date_%y-%m-%d_time_%H-%M-%S')
PROJECT=/ceph/hpc/home/eujoeyo/group_space/joey/workspace/Megatron-LM
TARGET_DIR="/workspace/Megatron-LM"
CONTAINER_PATH="/ceph/hpc/home/eujoeyo/group_space/containers/megatron-deepspeed.sif"
LOGGING=$PROJECT/logs
echo "SLURM_JOB_CPUS_PER_NODE" $SLURM_JOB_CPUS_PER_NODE
echo "NPROC_PER_NODE" $NPROC_PER_NODE
echo "SLURM_JOB_NAME" $SLURM_JOB_NAME
echo "SLURM_JOB_ID" $SLURM_JOB_ID
echo "SLURM_JOB_NODELIST" $SLURM_JOB_NODELIST
echo "SLURM_JOB_NUM_NODES" $SLURM_JOB_NUM_NODES
echo "SLURM_LOCALID" $SLURM_LOCALID
echo "SLURM_NODEID" $SLURM_NODEID
echo "SLURM_PROCID" $SLURM_PROCID
cmd="srun -l --output=$LOGGING/srun_$DATETIME.log \
  singularity exec --nv --pwd /workspace/Megatron-LM --bind $PROJECT:$TARGET_DIR $CONTAINER_PATH ./preprocess.sh"
echo "Executing:"
echo $cmd
$cmd
set +x
exit 0
