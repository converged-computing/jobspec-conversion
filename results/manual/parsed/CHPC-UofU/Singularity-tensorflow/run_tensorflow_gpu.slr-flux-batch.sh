#!/bin/bash
#FLUX: --job-name=arid-lettuce-6432
#FLUX: --urgency=16

nvidia-smi
ml purge
ml tensorflow/1.0.1.gpu
cd /uufs/chpc.utah.edu/common/home/u0101881/containers/singularity/containers/chpc/tensorflow/example
tensorflow-gpu helloworld.py
