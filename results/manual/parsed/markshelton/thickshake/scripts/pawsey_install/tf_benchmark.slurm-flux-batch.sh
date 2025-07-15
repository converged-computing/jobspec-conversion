#!/bin/bash
#FLUX: --job-name=tf_test
#FLUX: --queue=gpuq
#FLUX: -t=600
#FLUX: --priority=16

module load gcc/5.4.0 broadwell
module load tensorflow
srun --export=ALL python tf_cnn_benchmarks/tf_cnn_benchmarks.py --num_gpus=4 --batch_size=64 --model=resnet50 --variable_update=parameter_server
