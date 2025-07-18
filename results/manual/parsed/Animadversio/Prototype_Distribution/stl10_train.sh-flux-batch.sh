#!/bin/bash
#FLUX: --job-name=evasive-toaster-0929
#FLUX: -c=16
#FLUX: --queue=gpu_quad
#FLUX: -t=14400
#FLUX: --urgency=16

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
