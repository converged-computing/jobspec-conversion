#!/bin/bash
#FLUX: --job-name=salted-knife-8237
#FLUX: -N=2
#FLUX: --queue=defq
#FLUX: --urgency=16

module load shared keras/2.1.5 cuda91/toolkit/9.1.85 cm-ml-python3deps/2.0.0 ml-python3/tensorflow/1.10.1  openmpi3/gcc/64/3.0.0 cudnn/7.0
srun --gres=gpu:1 /home/jluu13/seniorProjectTest/seniorProject3/face_recognition.py
