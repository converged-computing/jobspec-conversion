#!/bin/bash
#FLUX: --job-name=misunderstood-animal-3649
#FLUX: -c=24
#FLUX: -t=43200
#FLUX: --urgency=16

module restore tensorenvironment
SOURCEDIR=~/scratch/Pointnet
source ~/Workspace/TensorFlowEnvironment/bin/activate
tensorboard --logdir=./logs --host 0.0.0.0 --load_fast false & python $SOURCEDIR/train.py
