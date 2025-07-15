#!/bin/bash
#FLUX: --job-name=phat-onion-7633
#FLUX: -t=604800
#FLUX: --urgency=16

export KERAS_BACKEND='tensorflow'
export command='python train.py --path_opt options/tools/minhmul_noatt_train_2048.yaml'

ml GCC/6.4.0-2.28  CUDA/9.0.176  OpenMPI/2.1.1
export KERAS_BACKEND="tensorflow"
export command="python train.py --path_opt options/tools/minhmul_noatt_train_2048.yaml"
echo "$command"
srun $command
wait
