#!/bin/bash
#FLUX: --job-name=anxious-snack-9727
#FLUX: -N=2
#FLUX: --urgency=16

module load Anaconda2
mpirun python bcast.py
