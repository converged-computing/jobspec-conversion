#!/bin/bash
#FLUX: --job-name=tensorflow_gpu_example
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

module purge
module load tensorflow-gpu/py39/2.9
python tf_hello.py
