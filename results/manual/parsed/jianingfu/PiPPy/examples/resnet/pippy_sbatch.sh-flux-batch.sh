#!/bin/bash
#FLUX: --job-name=mnist_pippy
#FLUX: -c=12
#FLUX: --queue=train
#FLUX: -t=3600
#FLUX: --priority=16

srun --label pippy_wrapper.sh
