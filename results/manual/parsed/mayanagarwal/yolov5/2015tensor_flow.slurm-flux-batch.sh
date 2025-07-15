#!/bin/bash
#FLUX: --job-name=creamy-staircase-6818
#FLUX: --queue=shortgpgpu
#FLUX: -t=300
#FLUX: --priority=16

module purge
source /usr/local/module/spartan_old.sh
module load Tensorflow/1.8.0-intel-2017.u2-GCC-6.2.0-CUDA9-Python-3.5.2-GPU
python tensor_flow.py
