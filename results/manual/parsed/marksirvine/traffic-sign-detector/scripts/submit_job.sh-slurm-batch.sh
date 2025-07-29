#!/bin/bash
#FLUX: --job-name=tsr
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

module add libs/tensorflow/1.2
srun python tsr.py
wait
