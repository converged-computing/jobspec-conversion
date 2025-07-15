#!/bin/bash
#FLUX: --job-name=outstanding-ricecake-6562
#FLUX: -t=604800
#FLUX: --urgency=16

export PYTHONPATH='${PWD}:$PYTHONPATH'
export KERAS_BACKEND='tensorflow'
export command='python main/loop_train_v100.py'

ml GCC/6.4.0-2.28  CUDA/9.0.176  OpenMPI/2.1.1
export PYTHONPATH=${PWD}:$PYTHONPATH
export KERAS_BACKEND="tensorflow"
export command="python main/loop_train_v100.py"
echo "$command"
srun $command
wait
