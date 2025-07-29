#!/bin/bash
#SBATCH --job-name=sup_lc
#SBATCH --output=srun_outputs/B10_lc_sup_rn18_100_%j.out
#SBATCH --error=srun_outputs/B10_lc_sup_rn18_100_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=04:00:00
#SBATCH --partition=booster
#SBATCH --constraint=ntasks-per-node=4

export CUDA_VISIBLE_DEVICES='0,1,2,3'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load Python
module load torchvision
module load OpenCV
module load scikit
module load TensorFlow
source /p/project/hai_dm4eo/wang_yi/env1/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u so2sat_B10_resnet_LC.py \
--data_dir /p/project/hai_dm4eo/wang_yi/data/so2sat-lcz42/ \
--bands B10 \
--checkpoints_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-review/src/checkpoints/so2sat/sup_lc/B10_rn18_100 \
--backbone resnet18 \
--train_frac 1.0 \
--batchsize 256 \
--lr 0.2 \
--schedule 10 20 \
--epochs 30 \
--num_workers 8 \
--seed 42 \
--dist_url $dist_url \
