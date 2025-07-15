#!/bin/bash
#FLUX: --job-name=scruptious-muffin-9454
#FLUX: --priority=16

module add libs/tensorflow/1.2
srun python tsr.py
wait
