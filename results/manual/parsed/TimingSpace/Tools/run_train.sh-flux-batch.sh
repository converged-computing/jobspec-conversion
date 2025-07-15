#!/bin/bash
#FLUX: --job-name=persnickety-kerfuffle-7447
#FLUX: --priority=16

nvidia-docker run --rm --ipc=host -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets  -v /home/$USER:/home/$USER  xiangwei/pytorch:cu80-latest sh /home/wangxiangwei/Program/Tools/train.sh
