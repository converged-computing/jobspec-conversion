#!/bin/bash
#SBATCH --output=logs/fastflow_waymo_toy_%a_%j.out
#SBATCH --error=logs/fastflow_waymo_toy_%a_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --partition=amdgpufast
#SBATCH --constraint=ntasks-per-node=4

ml torchsparse
cd $HOME/motion_supervision
python -u train.py $SLURM_ARRAY_TASK_ID
