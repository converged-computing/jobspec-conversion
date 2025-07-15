#!/bin/bash
#FLUX: --job-name=purple-nunchucks-2214
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python tf_cnn_benchmarks.py --batch_size=32 --model=alexnet --variable_update=parameter_server --device=cpu --data_format=NHWC
