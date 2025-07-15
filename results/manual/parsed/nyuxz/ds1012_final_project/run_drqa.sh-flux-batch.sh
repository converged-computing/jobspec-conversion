#!/bin/bash
#FLUX: --job-name=drqa
#FLUX: -c=2
#FLUX: -t=36000
#FLUX: --urgency=16

module load python3/intel/3.6.3
module load pytorch/python3.6/0.3.0_4
module load cuda/8.0.44
module load cudnn/8.0v5.1
module load msgpack
time python3 src/main.py
