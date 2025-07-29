#!/bin/bash
#SBATCH --job-name=dino_b2
#SBATCH --output=srun_outputs/B2_train_dino_vit_s_8_crop_%j.out
#SBATCH --error=srun_outputs/B2_train_dino_vit_s_8_crop_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=12:00:00
#SBATCH --partition=booster
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
srun python -u main_dino_B2.py \
--data_path /p/scratch/hai_dm4eo/wang_yi/BigEarthNet_LMDB \
--output_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-s1s2/src/checkpoints/dino/B2_vit_s_8_crop \
--bands B2 \
--lmdb \
--arch vit_small \
--patch_size 8 \
--use_fp16 False \
--num_workers 8 \
--batch_size_per_gpu 64 \
--epochs 100 \
--warmup_epochs=10 \
--lr 0.0005 \
--optimizer adamw \
--is_slurm_job \
--dist_url $dist_url \
--resume \
