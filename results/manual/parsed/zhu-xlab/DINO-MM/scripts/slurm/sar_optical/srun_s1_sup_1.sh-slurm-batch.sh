#!/bin/bash
#SBATCH --job-name=s1_sup
#SBATCH --output=srun_outputs/B2_sup_vit_s_8_1_%j.out
#SBATCH --error=srun_outputs/B2_sup_vit_s_8_1_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=4

export CUDA_VISIBLE_DEVICES='0,1,2,3'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load GCCcore/.9.3.0
module load Python
module load torchvision
module load OpenCV
module load scikit
module load TensorFlow
source /p/project/hai_dm4eo/wang_yi/env1/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u sup_vit_s1_moco.py \
--data /p/scratch/hai_dm4eo/wang_yi/BigEarthNet_LMDB \
--output_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-s1s2/src/checkpoints/sup/B2_vit_s_8_1 \
--lmdb \
--train_frac 0.01 \
--arch vit_small \
--workers 8 \
--batch_size 64 \
--epochs 100 \
--lr 0.001 \
--optimizer AdamW \
--is_slurm_job \
--dist_url $dist_url \
