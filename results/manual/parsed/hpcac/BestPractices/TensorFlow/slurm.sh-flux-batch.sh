#!/bin/bash
#FLUX: --job-name=tensorflow
#FLUX: --queue=jupiter
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load ml/tensorflow/1.4.1-py27
python test.py
