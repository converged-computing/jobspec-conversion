#!/bin/bash
#FLUX: --job-name=equiparam_32E
#FLUX: -N=2
#FLUX: --urgency=16

IB_INTERFACES=mlx5_0,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7,mlx5_8,mlx5_9
srun --output=/mnt/shared/slurm_logs/equiparam/32E.log \
    sudo docker run --network=host --ipc=host --privileged --shm-size=1800gb --gpus all --expose 2222 --rm \
    -e NCCL_IB_HCA=$IB_INTERFACES -e NCCL_IB_CUDA_SUPPORT=1 \
    -v /mnt/shared/datasets/:/datasets \
    -v /mnt/shared/checkpoints/:/checkpoints \
    -v /mnt/shared/code/megarun/Megatron-LM/:/opt/Megatron-LM \
    zyphra/megatron_experimental:latest \
    /opt/Megatron-LM/examples/megarun_slurm/equisizing_suite/moe_32E_bare.sh
