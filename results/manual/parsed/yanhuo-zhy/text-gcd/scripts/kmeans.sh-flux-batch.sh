#!/bin/bash
#FLUX: --job-name=arid-egg-6848
#FLUX: -c=5
#FLUX: --queue=general
#FLUX: --urgency=16

 # @Author: yanhuo 1760331284@qq.com
 # @Date: 2023-11-11 16:01:59
 # @LastEditors: yanhuo 1760331284@qq.com
 # @LastEditTime: 2024-03-04 15:35:17
 # @FilePath: \text-gcd\scripts\kmeans.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
module load gcc/gcc-10.2.0
module load nvidia/cuda-11.1 nvidia/cudnn-v8.1.1.33-forcuda11.0-to-11.2
source /home/pszzz/miniconda3/bin/activate zhy
CUDA_VISIBLE_DEVICES=0 python kmeans.py \
 --dataset_name='imagenet_100' \
 --experiment_name='cub_two_kmeans'
CUDA_VISIBLE_DEVICES=0 python kmeans.py \
 --dataset_name='scars' \
 --experiment_name='cifar100_two_kmeans'
