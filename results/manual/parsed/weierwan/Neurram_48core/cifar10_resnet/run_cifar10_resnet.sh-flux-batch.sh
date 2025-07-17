#!/bin/bash
#FLUX: --job-name=outstanding-avocado-9851
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: --urgency=16

ml load py-tensorflow/2.1.0_py36
ml load py-keras/2.3.1_py36
srun python cifar10_resnet.py
