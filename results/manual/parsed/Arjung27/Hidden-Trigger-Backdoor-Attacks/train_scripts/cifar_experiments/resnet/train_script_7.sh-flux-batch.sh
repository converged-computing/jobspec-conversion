#!/bin/bash
#FLUX: --job-name=res17
#FLUX: -c=4
#FLUX: --queue=scavenger
#FLUX: -t=36000
#FLUX: --urgency=16

python generate_poison.py cfg_CIFAR/singlesource_singletarget_binary_finetune_3/experiment_0017.cfg &&
python finetune_and_test.py cfg_CIFAR/singlesource_singletarget_binary_finetune_3/experiment_0017.cfg
