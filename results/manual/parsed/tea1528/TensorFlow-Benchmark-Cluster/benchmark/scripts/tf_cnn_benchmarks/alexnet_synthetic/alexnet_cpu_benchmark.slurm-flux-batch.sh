#!/bin/bash
#FLUX: --job-name=crusty-peanut-5707
#FLUX: -t=72000
#FLUX: --urgency=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python tf_cnn_benchmarks.py --batch_size=32 --model=alexnet --variable_update=parameter_server --device=cpu --data_format=NHWC
