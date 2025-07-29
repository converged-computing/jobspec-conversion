#!/bin/bash
#FLUX --job-name=buttery-peanut-7945
#FLUX -c=32
#FLUX --queue=research
#FLUX -t=345600
#FLUX --urgency=16

module load nvidia/cuda/11.3
python setup.py build_ext --inplace
python train_joint.py -c configs/joint/$1.yaml -n $2 -g $3
