#!/bin/bash
#FLUX --job-name=quirky-puppy-0854
#FLUX -N=2
#FLUX -c=4
#FLUX --queue=amd_a100nv_8
#FLUX -t=86400
#FLUX --urgency=16

module load gcc/10.2.0 cuda/11.4 cudampi/openmpi-4.1.1
source ~/.bashrc
conda activate horovod
srun python tf_keras_fashion_mnist.py
