#!/bin/bash
#FLUX: --job-name=multinode-example
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --gpus-per-task=4
#FLUX: --queue=a800 #分区
#FLUX: --priority=16

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
for NODE in $NODELIST; do
    if [ "$NODE" == "$MASTER_NODE" ]; then
         srun --nodes=1 --ntasks=1 -w $NODE \
         singularity run --nv \
        --pwd /workspaces/examples-main/distributed/minGPT-ddp/mingpt \
        -B /data/hpc/home/guodong.li/:/workspaces:rw \
        pytorch-multinode.sif \
        torchrun --nproc_per_node=4 \
        --nnodes=$NODE_NUM \
        --node_rank=0 \
        --master_addr=$MASTER_NODE \
        --master_port=29500 \
        main.py &
    else
        ((NODE_COUNT++))
        srun --nodes=1 --ntasks=1 -w $NODE \
        singularity run --nv \
        --pwd /workspaces/examples-main/distributed/minGPT-ddp/mingpt \
        -B /data/hpc/home/guodong.li/:/workspaces:rw \
        pytorch-multinode.sif \
        torchrun --nproc_per_node=4 \
        --nnodes=$NODE_NUM \
        --node_rank=$NODE_COUNT \
        --master_addr=$MASTER_NODE \
        --master_port=29500 \
        main.py &
    fi
done
wait
