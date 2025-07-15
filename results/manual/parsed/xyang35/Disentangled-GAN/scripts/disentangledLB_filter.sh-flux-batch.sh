#!/bin/bash
#FLUX: --job-name=lovable-banana-4648
#FLUX: --urgency=16

set -e
cd ..
netG=resnet_9blocks
nonlinear=sigmoid
lambda_A=10
lambda_TV=0
filtering=guided
lr=0.0002
id=$1
name=disentangledLB_A${lambda_A}_TV${lambda_TV}_lr${lr}_${filtering}_id${id}
model=disentangled_LB
dataroot=/home-4/xyang35@umd.edu/work/xyang/GAN/Haze/D-HAZY/NYU
checkpoints_dir=/home-4/xyang35@umd.edu/work/xyang/GAN/Haze/D-HAZY/checkpoints
results_dir=/home-4/xyang35@umd.edu/work/xyang/GAN/Haze/D-HAZY/results/
python test.py --dataroot $dataroot \
    --checkpoints_dir $checkpoints_dir \
    --results_dir $results_dir \
    --name $name --model $model --which_model_depth aod --which_model_netG $netG \
    --non_linearity $nonlinear  --pooling --no_dropout --depth_reverse \
    --filtering $filtering \
    --dataset_mode depth --display_id 0 --serial_batches --phase test --how_many 100
echo "Evaluation ..."
cd tools
