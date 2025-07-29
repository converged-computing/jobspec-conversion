#!/bin/bash
#SBATCH --job-name=Train_Ralis_CAMVID_Only
#SBATCH --account=gutintelligencelab
#SBATCH --output=Train_Ralis_CAMVID_Only_%A_%a.out
#SBATCH --error=Train_Ralis_CAMVID_Only_%A_%a.err
#SBATCH --mail-user=pm2kb@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:4
#SBATCH --time=3-00:00:00

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
