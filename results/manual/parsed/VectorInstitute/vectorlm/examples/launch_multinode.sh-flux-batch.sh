#!/bin/bash
#FLUX: --job-name=llama7b-2-multinode
#FLUX: -N=2
#FLUX: -c=24
#FLUX: --queue=a100
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_ADDR='$(hostname --fqdn)'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')'
export RDVZ_ID='$RANDOM'
export NCCL_IB_DISABLE='1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.'
export NCCL_DEBUG='WARN'
export NCCL_DEBUG_SUBSYS='WARN'
export LOGLEVEL='INFO'
export PYTHONFAULTHANDLER='1'

export MASTER_ADDR="$(hostname --fqdn)"
export MASTER_PORT="$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')"
export RDVZ_ID=$RANDOM
echo "RDZV Endpoint $MASTER_ADDR:$MASTER_PORT"
export NCCL_IB_DISABLE=1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.
export NCCL_DEBUG=WARN
export NCCL_DEBUG_SUBSYS=WARN
export LOGLEVEL=INFO
export PYTHONFAULTHANDLER=1
srun -p $SLURM_JOB_PARTITION \
    -c $SLURM_CPUS_ON_NODE \
    -N $SLURM_JOB_NUM_NODES \
    --mem=0 \
    --gres=gpu:$SLURM_JOB_PARTITION:$SLURM_GPUS_ON_NODE \
    bash -c 'torchrun \
    --nproc-per-node=$SLURM_GPUS_ON_NODE \
    --nnodes=$SLURM_JOB_NUM_NODES \
    --rdzv-endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv-id $RDVZ_ID \
    --rdzv-backend c10d \
    llama_example.py --yaml_path ../configs/config.yaml'
