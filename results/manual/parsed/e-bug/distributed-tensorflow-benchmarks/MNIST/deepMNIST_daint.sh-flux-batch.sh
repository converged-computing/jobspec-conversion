#!/bin/bash
#FLUX: --job-name=deepMNIST
#FLUX: -t=600
#FLUX: --priority=16

export WORKON_HOME='~/Envs'

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.1.0-CrayGNU-2016.11-cuda-8.0-Python-3.5.2
export WORKON_HOME=~/Envs
source $WORKON_HOME/tf-daint/bin/activate
cd $HOME/MNIST
srun python deepMNIST.py
deactivate
