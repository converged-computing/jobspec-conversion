#!/bin/bash
#FLUX: --job-name=bumfuzzled-snack-1322
#FLUX: --exclusive
#FLUX: --queue=production-cluster  # Adjust this for your cluster
#FLUX: --priority=16

export CMD=' \'
export LAUNCHER='ACCELERATE_LOG_LEVEL=info accelerate launch \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'

set -x -e
source ~/.bashrc
conda activate handbook
echo "START TIME: $(date)"
MODEL=$1
TASK=$2
PRECISION=$3
ACCELERATOR=$4
OPTIONAL_ARGS=$5
NUM_NODES=$SLURM_NNODES
GPUS_PER_NODE=8
WORLD_SIZE=$(($NUM_NODES*$GPUS_PER_NODE))
CONFIG_FILE=recipes/$MODEL/$TASK/config_$PRECISION.yaml
GRAD_ACC_STEPS=$(grep 'gradient_accumulation_steps' $CONFIG_FILE | awk '{print $2}')
IFS=' ' read -ra ARGS <<< "$OPTIONAL_ARGS"
for arg in "${ARGS[@]}"; do
    if [[ "$arg" == "--gradient_accumulation_steps="* ]]; then
        # Extract the value after the equals sign
        GRAD_ACC_STEPS="${arg#*=}"
        break  # Exit the loop once we find the desired argument
    fi
done
echo "Gradient accumulation steps: $GRAD_ACC_STEPS"
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
export CMD=" \
    scripts/run_$TASK.py $CONFIG_FILE $OPTIONAL_ARGS
    "
export LAUNCHER="ACCELERATE_LOG_LEVEL=info accelerate launch \
    --config_file recipes/accelerate_configs/$ACCELERATOR.yaml  \
    --gradient_accumulation_steps $GRAD_ACC_STEPS \
    --num_machines $NUM_NODES \
    --num_processes $WORLD_SIZE \
    --main_process_ip $MASTER_ADDR \
    --main_process_port $MASTER_PORT \
    --machine_rank \$SLURM_PROCID \
    --rdzv_conf "rdzv_backend=c10d,rdzv_endpoint=$MASTER_ADDR:$MASTER_PORT" \
    --max_restarts 1 \
    --role \$(hostname -s): \
    --tee 3 \
    "
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --role \$SLURMD_NODENAME: $CMD" 2>&1
echo "END TIME: $(date)"
