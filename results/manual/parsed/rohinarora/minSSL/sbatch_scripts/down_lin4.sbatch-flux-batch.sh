#!/bin/bash
#FLUX: --job-name=dl4
#FLUX: -c=2
#FLUX: --queue=multigpu
#FLUX: -t=86400
#FLUX: --urgency=16

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr29_23-17-12_d1008_cifar10_resnet18" --comment "_resnet18_cifar10_cfg_linear_ssl" 
