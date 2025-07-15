#!/bin/bash
#FLUX: --job-name=hairy-cherry-4702
#FLUX: --urgency=16

module add libs/tensorflow/1.2
srun python tsr.py
wait
