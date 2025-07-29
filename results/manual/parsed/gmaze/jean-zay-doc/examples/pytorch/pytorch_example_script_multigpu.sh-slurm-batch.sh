#!/bin/bash
#FLUX: --job-name=pytorch_mnist
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

cd $WORK/jean-zay-doc/examples/pytorch
module purge
module load pytorch-gpu/py3/1.4.0 
GAMMA_STEP=('0.1' '0.2' '0.3' '0.4' '0.5' '0.6' '0.7' '0.8' '0.9' '1.0') 
python ./mnist_example.py --gamma ${GAMMA_STEP[$SLURM_ARRAY_TASK_ID]} &
