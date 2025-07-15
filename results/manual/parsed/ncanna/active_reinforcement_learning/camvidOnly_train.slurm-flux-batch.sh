#!/bin/bash
#FLUX: --job-name=Train_Ralis_CAMVID_Only
#FLUX: --queue=gpu
#FLUX: --priority=16

module purge
module --ignore-cache load anaconda/2019.10-py3.7
module --ignore-cache load singularity/3.5.2
ckpt_path='/scratch/pm2kb/ckpt_seg'
data_path='/home/pm2kb/RL_proj/SegNet'
for seed in 20 50 82 12 4560
    do
    singularity run --nv ~/pytorch-1.4.0-py37.sif /home/pm2kb/RL_proj/ralis-master/run.py --exp-name 'RALIS_camvid_train_seed'$seed --full-res --region-size 80 90 \
    --snapshot 'best_jaccard_val.pth' --al-algorithm 'ralis' \
    --ckpt-path $ckpt_path --data-path $data_path \
    --rl-episodes 100 --rl-buffer 600 --lr-dqn 0.001\
    --load-weights --exp-name-toload 'gta_pretraining_camvid' \
    --dataset 'camvid' --lr 0.001 --train-batch-size 32 --val-batch-size 4 --patience 10 \
    --input-size 224 224 --only-last-labeled --budget-labels 480  --num-each-iter 24  --rl-pool 20 --seed $seed
    done
