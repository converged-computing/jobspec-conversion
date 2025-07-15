#!/bin/bash
#FLUX: --job-name="MNIST-00"
#FLUX: -c=40
#FLUX: -t=600
#FLUX: --priority=16

module load tensorflow/2.4.1 numpy/1.19.5 keras/2.4.3 matplotlib/3.3.4
srun python3 slurm_tf_python3_mnist.py
