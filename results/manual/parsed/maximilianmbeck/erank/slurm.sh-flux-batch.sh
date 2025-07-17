#!/bin/bash
#FLUX: --job-name=quirky-peanut-butter-8243
#FLUX: -c=32
#FLUX: --queue=compute
#FLUX: --urgency=16

export MKL_NUM_THREADS='$NUM_CORES OMP_NUM_THREADS=$NUM_CORES'

eval "$(conda shell.bash hook)"
conda activate subspaces
which python
NUM_CORES=32
export MKL_NUM_THREADS=$NUM_CORES OMP_NUM_THREADS=$NUM_CORES
python run_sweep.py --config-name 11.7.1_mnist_lenet_rotatedtasks.yaml
