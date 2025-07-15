#!/bin/bash
#FLUX: --job-name=dirty-animal-9904
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --num_gpus=4 --batch_size=32 --model=inception3 --variable_update=parameter_server
