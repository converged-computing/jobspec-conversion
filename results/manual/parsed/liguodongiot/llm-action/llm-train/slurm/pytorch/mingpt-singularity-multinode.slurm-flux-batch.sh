#!/bin/bash
#FLUX: --job-name=multinode-example
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=4
#FLUX: --queue=a800
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='bond0'

NODELIST=$(scontrol show hostname $SLURM_JOB_NODELIST)
MASTER_NODE=$(head -n 1 <<< "$NODELIST")
NODE_COUNT=0
NODE_NUM=($(echo $NODELIST | tr " " "\n" | wc -l))
echo $SLURM_NODEID
echo $NODELIST
echo $MASTER_NODE
echo $NODE_NUM
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=bond0
srun --mpi=pmix_v3 singularity run --nv --pwd /workspaces/examples-main/distributed/minGPT-ddp/mingpt -B /data/hpc/home/guodong.li/:/workspaces:rw pytorch-multinode.sif torchrun --nproc_per_node=4 main.py
