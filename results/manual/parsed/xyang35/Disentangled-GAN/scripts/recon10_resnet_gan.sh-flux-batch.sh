#!/bin/bash
#FLUX: --job-name=buttery-pancake-2696
#FLUX: --priority=16

cd ..
name=recongan10_resnet_nyu
model=recon
dataroot=/home-4/xyang35@umd.edu/data/xyang/Haze/D-HAZY/NYU
checkpoints_dir=/home-4/xyang35@umd.edu/data/xyang/Haze/D-HAZY/checkpoints
results_dir=/home-4/xyang35@umd.edu/data/xyang/Haze/D-HAZY/results/
python train.py --dataroot $dataroot \
    --checkpoints_dir $checkpoints_dir \
    --name $name --model $model --no_dropout\
    --pool_size 50 --niter 100  --niter_decay 50 --lambda_A 100 \
    --gpu_ids 0,1 --batchSize 8 --display_id 0  --dataset_mode depth --depth_reverse    # reverse depth as transition map
python test.py --dataroot $dataroot \
    --checkpoints_dir $checkpoints_dir \
    --results_dir $results_dir \
    --name $name --model $model --no_dropout \
    --phase test --which_epoch 100  --dataset_mode depth --display_id 0 --serial_batches --depth_reverse
python test.py --dataroot $dataroot \
    --checkpoints_dir $checkpoints_dir \
    --results_dir $results_dir \
    --name $name --model $model --no_dropout \
    --phase test --dataset_mode depth --display_id 0 --serial_batches --depth_reverse
cd $checkpoints_dir/$name
zip ${name}_checkpoints.zip web/ -r
cd $results_dir
zip ${name}_results.zip $name -r
