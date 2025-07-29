#!/bin/bash
#SBATCH --output=attention_gan_%j.out
#SBATCH --error=attention_gan_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --partition=gpu
#SBATCH --nodelist=clamps

srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /home/$USER:/home/$USER madratman/theano_keras_cuda8_cudnn5 python /home/ratneshm/projects/attention_gan/model.py
