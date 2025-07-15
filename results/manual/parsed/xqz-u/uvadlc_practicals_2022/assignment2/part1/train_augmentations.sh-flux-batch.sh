#!/bin/bash
#FLUX: --job-name=resnet18_imagenet_cifar100_augmented
#FLUX: --queue=gpu_shared_course
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
root="/scratch/$USER"
mkdir -p $root
code_dir="/home/$USER/uvadlc_practicals_2022/assignment2/part1"
augmentations=(rand_hflip rand_crop color_jitter all)
i=$SLURM_ARRAY_TASK_ID
aug=${augmentations[i]}
echo "Resnet18 Imagenet-1K -> CIFAR100, method: $aug"
python $code_dir/train.py --data_dir $root --augmentation_name $aug
