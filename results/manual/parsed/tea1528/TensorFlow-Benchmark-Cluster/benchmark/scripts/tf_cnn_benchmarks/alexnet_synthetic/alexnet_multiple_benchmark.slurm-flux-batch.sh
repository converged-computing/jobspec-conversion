#!/bin/bash
#FLUX: --job-name=wobbly-bicycle-0503
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=alexnet --variable_update=parameter_server
