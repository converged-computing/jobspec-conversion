#!/bin/bash
#FLUX: --job-name=robustness_resnet
#FLUX: --queue=gpu_shared_course
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
root="/scratch/$USER"
mkdir -p $root
code_dir="/home/$USER/uvadlc_practicals_2022/assignment2/part1"
echo "Fine-tuned Resnet18 on noisy CIFAR100"
python $code_dir/robustness_resnet.py --resume $code_dir/resnet18_cifar100_ckpt
