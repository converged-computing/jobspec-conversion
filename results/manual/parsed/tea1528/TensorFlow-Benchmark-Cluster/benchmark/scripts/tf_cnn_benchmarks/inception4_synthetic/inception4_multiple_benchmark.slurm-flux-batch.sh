#!/bin/bash
#FLUX: --job-name=doopy-staircase-6244
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --urgency=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --num_gpus=1 --batch_size=32 --model=inception4 --variable_update=parameter_server
