#!/bin/bash
#FLUX: --job-name=arch_data2
#FLUX: --queue=ce-mri
#FLUX: -t=86400
#FLUX: --urgency=16

source activate simclr1
python pre_train.py --dataset-name cifar10  --arch resnet50 --comment "_cifar10_resnet50"
