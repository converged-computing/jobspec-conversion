#!/bin/bash

#FLUX: -N 1
#FLUX: -n 16
#FLUX: --tasks-per-node=16
#FLUX: --gpus=1
#FLUX: -p standard
#FLUX: -o sing_tf.out
#FLUX: -e sing_tf.err
#FLUX: -J sing_tf

#---------------------------------------------------------------------
module load singularity
cd /extra/vikasy
singularity run --nv tf_gpu-1.2.0-cp35-cuda8-cudnn51.img /extra/vikasy/4chars_Prefix_Suffix_Experiments/Spanish/main.py