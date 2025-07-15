#!/bin/bash
#FLUX: --job-name=ddc model 
#FLUX: --queue=gpu
#FLUX: -t=79200
#FLUX: --urgency=16

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
python DDC.py
echo "completed job "s
