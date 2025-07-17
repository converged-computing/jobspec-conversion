#!/bin/bash
#FLUX: --job-name=expressive-bike-6033
#FLUX: -N=2
#FLUX: --urgency=16

module load Anaconda2
mpirun python bcast.py
