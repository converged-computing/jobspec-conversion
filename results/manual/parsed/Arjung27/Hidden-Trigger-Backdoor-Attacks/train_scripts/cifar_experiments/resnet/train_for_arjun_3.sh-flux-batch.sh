#!/bin/bash
#FLUX: --job-name=res3
#FLUX: -c=4
#FLUX: --queue=scavenger
#FLUX: -t=86400
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0 python generate_poison.py cfg_CIFAR/singlesource_singletarget_binary_finetune/experiment_0013.cfg &&
CUDA_VISIBLE_DEVICES=0 python finetune_and_test.py cfg_CIFAR/singlesource_singletarget_binary_finetune/experiment_0013.cfg
