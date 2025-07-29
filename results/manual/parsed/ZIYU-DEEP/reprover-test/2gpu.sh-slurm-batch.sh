#!/bin/bash
#SBATCH --account=gts-czhang355
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100:2
#SBATCH --mem=80G
#SBATCH --time=04:00:00
#SBATCH --partition=embers
#SBATCH --constraint=ntasks-per-node=2,A100-80GB

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
