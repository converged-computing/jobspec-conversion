#!/bin/bash
#FLUX: --job-name=lovable-squidward-3875
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='$HOME/pythonpackages/lib/python2.7/site-packages:$PYTHONPATH'
export THEANO_FLAGS='mode=FAST_RUN,device=gpu,floatX=float32,lib.cnmem=1'

export PYTHONPATH=$HOME/pythonpackages/lib/python:$PYTHONPATH
export PYTHONPATH=$HOME/pythonpackages/lib/python2.7/site-packages:$PYTHONPATH
module load python/2.7.9
module load cuda
module load cudnn
cd $HOME/luna16/src/deep
echo "starting python"
export THEANO_FLAGS='mode=FAST_RUN,device=gpu,floatX=float32,lib.cnmem=1'
srun -u python train.py ../../config/resnet98_56.ini
