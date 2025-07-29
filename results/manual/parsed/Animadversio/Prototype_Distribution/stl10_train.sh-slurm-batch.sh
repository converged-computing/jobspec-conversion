#!/bin/bash
#SBATCH --output=stl10_train_%A.%a.out
#SBATCH --mail-user=binxu_wang@hms.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=04:00:00
#SBATCH --partition=gpu_quad
#SBATCH --array=6-10

export unit_name='$(echo "$param_list" | head -n $SLURM_ARRAY_TASK_ID | tail -1)'

echo "$SLURM_ARRAY_TASK_ID"
param_list=\
'--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 1 --expname stl10_rn18_RND1_keepclr --cj_prob 0.0 --random_gray_scale 0.0
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 2 --expname stl10_rn18_RND2_keepclr  --cj_prob 0.0 --random_gray_scale 0.0
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 3 --expname stl10_rn18_RND3_keepclr  --cj_prob 0.0 --random_gray_scale 0.0
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 4 --expname stl10_rn18_RND4_keepclr  --cj_prob 0.0 --random_gray_scale 0.0
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 5 --expname stl10_rn18_RND5_keepclr  --cj_prob 0.0 --random_gray_scale 0.0
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 1 --expname stl10_rn18_RND1_clrjit
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 2 --expname stl10_rn18_RND2_clrjit
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 3 --expname stl10_rn18_RND3_clrjit
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 4 --expname stl10_rn18_RND4_clrjit
--max_epochs 100 --num_workers 16 --batch_size 1024 --seed 5 --expname stl10_rn18_RND5_clrjit
'
export unit_name="$(echo "$param_list" | head -n $SLURM_ARRAY_TASK_ID | tail -1)"
echo "$unit_name"
module load gcc/6.2.0
module load cuda/10.2
source  activate torch
cd ~/Github/Prototype_Distribution
python3 train/simclr_STL10train_O2.py $unit_name
