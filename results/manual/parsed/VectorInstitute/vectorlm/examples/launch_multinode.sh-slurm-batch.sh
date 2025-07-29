#!/bin/bash
#SBATCH --job-name=llama7b-2-multinode
#SBATCH --output=llama-2-7b.%j.out
#SBATCH --error=llama-2-7b.%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=0
#SBATCH --time=3-00:00:00
#SBATCH --qos=your_assigned_qos
#SBATCH --constraint=ntasks-per-node=1

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
