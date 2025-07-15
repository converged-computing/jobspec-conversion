#!/bin/bash
#FLUX: --job-name=strawberry-latke-9112
#FLUX: -c=96
#FLUX: --exclusive
#FLUX: --priority=16

export HF_HOME='/fsx/william/hf_home'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'

set -e
export HF_HOME=/fsx/william/hf_home
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
source /fsx/william/miniconda3/etc/profile.d/conda.sh
conda activate base
cd /fsx/william/nano-diffusion
srun --wait=60 --kill-on-bad-exit=1 \
    bash -c "torchrun \
                --nproc_per_node 8 \
                --nnodes $SLURM_NNODES \
                --master_addr $(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1) \
                --master_port 6000 \
                --max_restarts 0 \
                --tee 3 \
                --node_rank \$SLURM_PROCID \
                --role \$SLURMD_NODENAME: \
                train.py
            "
