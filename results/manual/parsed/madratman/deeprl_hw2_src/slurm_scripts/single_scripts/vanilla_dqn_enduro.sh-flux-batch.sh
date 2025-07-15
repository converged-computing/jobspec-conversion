#!/bin/bash
#FLUX: --job-name=expensive-general-0811
#FLUX: --urgency=16

srun echo "I am on"
srun echo $HOSTNAME
srun echo "I got gpu number"
srun echo $CUDA_VISIBLE_DEVICES
srun echo "let the training begin"
srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets -v /home/$USER:/home/$USER madratman/deeprl_hw /bin/bash -c "cd /home/ratneshm/courses/deeprl_hw2_src; python dqn_atari.py --env='enduro'"
