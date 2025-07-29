#!/bin/bash
#SBATCH --output=/usr/wiss/%u/slurm/logs/slurm-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:2,VRAM:24G
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --exclude=node14

export EXP_DIR='/storage/user/koestlel/dr_experiments/slurm/$SLURM_JOB_ID'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export EXP_DIR="/storage/user/koestlel/dr_experiments/slurm/$SLURM_JOB_ID"
echo "Master Node ($(hostname)) is up. Writing to: $EXP_DIR."
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
config=$1
shift 1
srun python train.py --config $config $EXP_DIR TRAIN.DEVICE slurm-ddp $@
