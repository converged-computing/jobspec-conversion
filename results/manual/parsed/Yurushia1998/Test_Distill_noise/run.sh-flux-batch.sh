#!/bin/bash
#FLUX: --job-name=expensive-taco-8310
#FLUX: -t=86400
#FLUX: --urgency=16

set -e
set -x
CUDA_VISIBLE_DEVICES=0 python -m ieg.main --dataset=cifar10_uniform_0.8 --network_name=resnet29 --probe_dataset_hold_ratio=0.0002 --checkpoint_path=ieg/checkpoints/ieg 
