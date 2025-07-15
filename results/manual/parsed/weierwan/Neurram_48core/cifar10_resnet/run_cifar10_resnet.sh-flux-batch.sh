#!/bin/bash
#FLUX: --job-name=blue-nalgas-6898
#FLUX: --priority=16

ml load py-tensorflow/2.1.0_py36
ml load py-keras/2.3.1_py36
srun python cifar10_resnet.py
