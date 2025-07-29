#!/bin/bash
#SBATCH --job-name=tutorial
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=60G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4

export MASTER_ADDR='$master_addr'
export MASTER_PORT='13579'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/central/groups/mthomson/zam/miniconda3/lib'
export TORCH_HOME='/groups/mthomson/zam/.cache/torch/hub/checkpoints'

module purge
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
export MASTER_PORT=13579
export NCCL_SOCKET_IFNAME=^docker0,lo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/central/groups/mthomson/zam/miniconda3/lib
export TORCH_HOME=/groups/mthomson/zam/.cache/torch/hub/checkpoints
source ~/.bashrc
srun python3 newmain.py tutorial ../data/query.fasta 4 --epochs 5 --strategy fsdp
