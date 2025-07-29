#!/bin/bash
#FLUX: --job-name=n2d model 
#FLUX: --queue=gpu
#FLUX: -t=79200
#FLUX: --urgency=16

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
echo "Running the n2d clustering algorithm"
python n2d_extract.py
echo "completed job "s
