#!/bin/bash
#FLUX: --job-name=Megatron-LM
#FLUX: -N=2
#FLUX: -c=32
#FLUX: --exclusive
#FLUX: --queue=Pretrain-Experiment
#FLUX: --urgency=16

export LOGLEVEL='INFO'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
echo SLURM_PROCID: $SLURM_PROCID
echo SLURM_NODEID: $SLURM_NODEID
export LOGLEVEL=INFO
PROJECT_ROOT=/aifs4su/code/
srun -l --ntasks-per-node=1 " docker run --net=host --ipc=host --rm --user $(id -u):$(id -g) --gpus all --shm-size=16g --ulimit memlock=-1 --privileged \
     -e NVIDIA_VISIBLE_DEVICES=all \
     -e NCCL_SOCKET_IFNAME=ibp \
     -e NCCL_IB_HCA=mlx5 \
     -e NCCL_DEBUG=INFO \
     -e NCCL_DEBUG_SUBSYS=ALL \
     -e GPUS_PER_NODE=8 \
     -e MASTER_ADDR=$head_node_ip \
     -e MASTER_PORT=6000 \
     -e NODE_RANK=$SLURM_PROCID \
     -e NNODES=2 \
     -e NCCL_DEBUG=INFO \
     -e CUDA_DEVICE_MAX_CONNECTIONS=10 \
     -e OMP_NUM_THREADS=10 \
     -v $PROJECT_ROOT/Megatron-LM:/workspace/megatron \
     -v $PROJECT_ROOT/dataset:/workspace/dataset \
     -v /run/mellanox/drivers:/run/mellanox/drivers:shared \
	 -v /etc/network:/etc/network \
	 -v /etc:/host/etc \
	 -v /lib/udev:/host/lib/udev \
     -v $PROJECT_ROOT/checkpoints:/workspace/checkpoints \
     -w /workspace/megatron \
     registry-intl.cn-hongkong.aliyuncs.com/sixpublic/pytorch:23.10-py3 \
     bash hkgai/launcher/scripts/pretrain/pretrain.sh "
