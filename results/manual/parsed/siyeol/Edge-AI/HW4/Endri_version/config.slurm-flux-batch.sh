#!/bin/bash
#FLUX: --job-name=creamy-eagle-0532
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/apps/cuda/10.1/lib64'

module load intel/18.0.2 python3/3.7.0
module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/apps/cuda/10.1/lib64
source $WORK/HW4_virtualenv/bin/activate
CUDA_VISIBLE_DEVICES=0 python $WORK/HW4_files/main_tf.py --model_class="VGG11" > $WORK/HW4_files/p1_q2_vgg11 &
CUDA_VISIBLE_DEVICES=1 python $WORK/HW4_files/main_tf.py --model_class="VGG16" > $WORK/HW4_files/p1_q2_vgg16 &
wait
