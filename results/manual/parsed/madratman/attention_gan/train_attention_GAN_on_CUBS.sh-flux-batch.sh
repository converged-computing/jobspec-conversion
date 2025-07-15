#!/bin/bash
#FLUX: --job-name=outstanding-hope-0981
#FLUX: --priority=16

srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /home/$USER:/home/$USER madratman/theano_keras_cuda8_cudnn5 python /home/ratneshm/projects/attention_gan/model.py
