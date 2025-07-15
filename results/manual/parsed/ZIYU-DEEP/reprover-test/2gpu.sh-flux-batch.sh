#!/bin/bash
#FLUX: --job-name=salted-gato-8298
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='ALL'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export MASTER_ADDR='$(scontrol show hostname ${SLURM_NODELIST} | head -n 1)'
export MASTER_PORT='12345'
export WORLD_SIZE='$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))'
export RANK='${SLURM_PROCID}'
export LOCAL_RANK='${SLURM_LOCALID}'

export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=ALL
export NCCL_SOCKET_IFNAME=^docker0,lo
export MASTER_ADDR=$(scontrol show hostname ${SLURM_NODELIST} | head -n 1)
export MASTER_PORT=12345
export WORLD_SIZE=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
export RANK=${SLURM_PROCID}
export LOCAL_RANK=${SLURM_LOCALID}
srun python generator/main.py fit --config generator/confs/cli_lean4_random_goal_driven_tactic_ckpt_resume_2gpu.yaml
