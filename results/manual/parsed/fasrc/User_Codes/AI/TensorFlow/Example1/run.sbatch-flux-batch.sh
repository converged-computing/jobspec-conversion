#!/bin/bash
#FLUX: --job-name=dnn
#FLUX: --queue=gpu_test
#FLUX: -t=180
#FLUX: --urgency=16

module load python/3.10.9-fasrc01
source activate tf2.12_cuda11
srun -n 1 --gres=gpu:1 python tf_mnist.py
