#!/bin/bash
#FLUX: --job-name=google_benchmark
#FLUX: -t=600
#FLUX: --urgency=16

export WORKON_HOME='~/Envs'

module use /apps/daint/UES/6.0.UP02/sandbox-dl/modules/all
module load daint-gpu
module load TensorFlow/1.1.0-CrayGNU-2016.11-cuda-8.0-Python-3.5.2
export WORKON_HOME=~/Envs
source $WORKON_HOME/tf-daint/bin/activate
cd ~/google-benchmarks
srun python tf_cnn_benchmarks/tf_cnn_benchmarks.py \
--num_gpus=1 \
--batch_size=64 \
--data_format=NCHW \
--use_nccl=True \
--variable_update=parameter_server \
--local_parameter_device=gpu \
--optimizer=sgd \
--model=inception3 \
--data_name=imagenet \
deactivate
