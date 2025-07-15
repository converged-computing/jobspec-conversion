#!/bin/bash
#FLUX: --job-name=ornery-leg-1316
#FLUX: -c=32
#FLUX: --queue=research
#FLUX: -t=345600
#FLUX: --priority=16

module load nvidia/cuda/11.3
python setup.py build_ext --inplace
python train_joint.py -c configs/joint/$1.yaml -n $2 -g $3
